import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:roadmap_ai/core/common/providers/theme_notifier.dart';
import 'package:roadmap_ai/core/common/toast/error.dart';
import 'package:roadmap_ai/core/constants/constants.dart';
import 'package:roadmap_ai/core/extensions/datetime_utility_extension.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/features/auth/presentation/providers/logout/logout_notifier.dart';
import 'package:roadmap_ai/features/auth/presentation/providers/profile/profile_notifier.dart';
import 'package:roadmap_ai/features/auth/presentation/widgets/profile_field.dart';
import 'package:roadmap_ai/features/community/presentation/providers/posts_stats/posts_stats_notifier.dart';
import 'package:roadmap_ai/features/community/presentation/widgets/post_stat_card.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileNotifier = ref.read(profileProvider.notifier);
    final profile = ref.watch(profileProvider);
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;
    final textTheme = context.textTheme;

    ref.listen(profileProvider, (_, next) {
      if (next is AsyncData && next.value?.error != null) {
        showErrorToast(context: context, error: "${next.value?.error}");
      }
    });

    final colorScheme = context.colorScheme;
    final userPostsStats = ref.watch(userPostStatsProvider);

    if (AppConstants.isAndroid) {
      return Scaffold(
        body: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 40),
          child: Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Profile',
                    style: textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'View personal information',
                    style: textTheme.bodyLarge!.copyWith(),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              profile.when(
                skipLoadingOnRefresh: false,
                data: (userDetails) {
                  final details = userDetails.userDetails;
                  return Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 60),
                        child: Animate(
                          delay: Duration(milliseconds: 400),
                          effects: [
                            SlideEffect(
                              begin: Offset(0, 0.1),
                              end: Offset.zero,
                              curve: Curves.ease,
                            ),
                            FadeEffect(curve: Curves.ease),
                          ],
                          child: Card(
                            elevation: 10,
                            child: Padding(
                              padding: EdgeInsetsGeometry.only(
                                top: 100,
                                left: 10,
                                right: 10,
                                bottom: 20,
                              ),
                              child: Column(
                                spacing: 20,
                                children: [
                                  Column(
                                    spacing: 10,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Icon(
                                            Icons.person,
                                            color: colorScheme.primary,
                                          ),
                                          Text(details.username),
                                        ],
                                      ),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Icon(
                                            Icons.email,
                                            color: colorScheme.primary,
                                          ),
                                          Text(details.email),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Icon(
                                            Icons.calendar_month,
                                            color: colorScheme.primary,
                                          ),
                                          Text(
                                            DateTime.parse(
                                              details.createdAt,
                                            ).formatDate(),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.all(4),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 10),
                                        Row(
                                          spacing: 10,
                                          children: [
                                            Expanded(
                                              child: Divider(
                                                color: colorScheme.primary,
                                              ),
                                            ),
                                            Text(
                                              'Account Stats',
                                              style: textTheme.titleLarge
                                                  ?.copyWith(
                                                    color:
                                                        colorScheme.onSurface,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            Expanded(
                                              child: Divider(
                                                color: colorScheme.primary,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        userPostsStats.maybeWhen(
                                          data: (posts) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              spacing: 10,
                                              children: [
                                                Expanded(
                                                  child: PostStatCard(
                                                    icon: Icons.article,
                                                    value: posts.totalPosts,
                                                    label: 'Posts',
                                                    textStyle:
                                                        textTheme.bodyLarge,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: PostStatCard(
                                                    icon: Icons.visibility,
                                                    value: posts.totalViews,
                                                    label: 'Total Views',
                                                    textStyle:
                                                        textTheme.bodyLarge,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: PostStatCard(
                                                    icon: Icons.favorite,
                                                    value: posts.totalLikes,
                                                    label: 'Total Likes',
                                                    textStyle:
                                                        textTheme.bodyLarge,
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                          orElse: () {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              spacing: 20,
                                              children: [
                                                Expanded(
                                                  child: PostStatCard(
                                                    icon: Icons.article,
                                                    value: null,
                                                    label: 'Posts',
                                                  ),
                                                ),
                                                Expanded(
                                                  child: PostStatCard(
                                                    icon: Icons.visibility,
                                                    value: null,
                                                    label: 'Total Views',
                                                  ),
                                                ),
                                                Expanded(
                                                  child: PostStatCard(
                                                    icon: Icons.favorite,
                                                    value: null,
                                                    label: 'Total Likes',
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Animate(
                        delay: Duration(milliseconds: 600),
                        effects: [
                          SlideEffect(
                            begin: Offset(0, 0.1),
                            end: Offset.zero,
                            curve: Curves.ease,
                          ),
                          FadeEffect(curve: Curves.ease),
                        ],
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: SizedBox(
                              width: screenHeight * 0.15,
                              height: screenHeight * 0.15,
                              child: Stack(
                                children: [
                                  // Main avatar image
                                  Container(
                                    width: screenHeight * 0.15,
                                    height: screenHeight * 0.15,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: colorScheme.primary,
                                      image: details.avatarUrl != null
                                          ? DecorationImage(
                                              image: NetworkImage(
                                                details.avatarUrl!,
                                              ),
                                              fit: BoxFit.cover,
                                            )
                                          : null,
                                    ),
                                    child: details.avatarUrl == null
                                        ? Icon(
                                            Icons.person,
                                            color: Colors.white,
                                            size: screenHeight * 0.1,
                                          )
                                        : null,
                                  ),
                                  // Bottom overlay container
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      height: screenHeight * 0.25 * 0.15,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withAlpha(150),
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(100),
                                          bottomRight: Radius.circular(100),
                                        ),
                                      ),
                                      child: Center(
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.camera_alt,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          onPressed: () async {
                                            final result = await FilePicker
                                                .platform
                                                .pickFiles(
                                                  type: FileType.image,
                                                );
                                            if (result != null) {
                                              profileNotifier.changeAvatar(
                                                result,
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
                loading: () {
                  return Padding(
                    padding: const EdgeInsets.only(top: 200),
                    child: Center(
                      child: LoadingAnimationWidget.threeRotatingDots(
                        color: colorScheme.primary,
                        size: 30,
                      ),
                    ),
                  );
                },
                error: (error, stack) => Center(
                  child: Column(
                    spacing: 20,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('$error'),
                      FilledButton(
                        onPressed: () {
                          ref.invalidate(profileProvider);
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Builder(
                builder: (context) {
                  final selectedTheme = ref.watch(themeProvider).value;
                  final notifier = ref.read(themeProvider.notifier);
                  return Row(
                    spacing: 10,
                    children: [
                      Text(
                        "Theme",
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      ChoiceChip(
                        label: Icon(Icons.light_mode),
                        selected: selectedTheme == ThemeMode.light,
                        onSelected: (value) {
                          notifier.setTheme(ThemeMode.light);
                        },
                        showCheckmark: false,
                      ),
                      ChoiceChip(
                        label: Icon(Icons.dark_mode),
                        selected: selectedTheme == ThemeMode.dark,
                        onSelected: (value) {
                          notifier.setTheme(ThemeMode.dark);
                        },
                        showCheckmark: false,
                      ),
                      ChoiceChip(
                        label: Icon(Icons.settings),
                        selected: selectedTheme == ThemeMode.system,
                        onSelected: (value) {
                          notifier.setTheme(ThemeMode.system);
                        },
                        showCheckmark: false,
                      ),
                    ],
                  );
                },
              ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(padding: EdgeInsets.all(12)),
                  onPressed: () {
                    _showLogoutConfirmationDialog(context, ref);
                  },
                  icon: Icon(Icons.logout),
                  iconAlignment: IconAlignment.end,
                  label: Text(
                    'Logout',
                    style: textTheme.bodyLarge?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            profile.when(
              data: (userDetails) {
                final details = userDetails.userDetails;
                return Column(
                  children: [
                    ClipOval(
                      child: SizedBox(
                        width: screenHeight * 0.25,
                        height: screenHeight * 0.25,
                        child: Stack(
                          children: [
                            // Main avatar image
                            Container(
                              width: screenHeight * 0.25,
                              height: screenHeight * 0.25,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colorScheme.primary,
                                image: details.avatarUrl != null
                                    ? DecorationImage(
                                        image: NetworkImage(details.avatarUrl!),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                              child: details.avatarUrl == null
                                  ? Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: screenHeight * 0.1,
                                    )
                                  : null,
                            ),
                            // Bottom overlay container
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: screenHeight * 0.25 * 0.2,
                                decoration: BoxDecoration(
                                  color: Colors.black.withAlpha(150),
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(100),
                                    bottomRight: Radius.circular(100),
                                  ),
                                ),
                                child: Center(
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    onPressed: () async {
                                      final result = await FilePicker.platform
                                          .pickFiles(type: FileType.image);
                                      if (result != null) {
                                        profileNotifier.changeAvatar(result);
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    ProfileField(icon: Icons.person, text: details.username),
                    SizedBox(height: screenHeight * 0.01),
                    ProfileField(icon: Icons.email, text: details.email),
                    SizedBox(height: screenHeight * 0.03),
                    FilledButton(
                      onPressed: () {
                        ref.read(logoutProvider.notifier).logout();
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          context.colorScheme.primary,
                        ),
                        textStyle: WidgetStateProperty.all(textTheme.bodyLarge),
                        padding: WidgetStateProperty.all(
                          EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.03,
                            vertical: screenHeight * 0.02,
                          ),
                        ),
                      ),
                      child: Text('Logout'),
                    ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Column(
                  children: [
                    Text('$error'),
                    ElevatedButton(
                      onPressed: () {
                        ref.invalidate(profileProvider);
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _showLogoutConfirmationDialog(
    BuildContext context,
    WidgetRef ref,
  ) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: Icon(Icons.warning, color: colorScheme.primary, size: 30),
          title: Text(
            "Are you sure you want to log out?",
            style: textTheme.bodyLarge,
          ),
          alignment: Alignment.center,
          actionsAlignment: MainAxisAlignment.spaceAround,
          actions: [
            OutlinedButton(
              onPressed: () => context.pop(),
              child: Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                ref.read(logoutProvider.notifier).logout();
                context.pop();
              },
              child: Text("Confirm"),
            ),
          ],
        );
      },
    );
  }
}
