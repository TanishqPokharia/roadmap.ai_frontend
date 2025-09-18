import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/features/auth/presentation/providers/logout/logout_notifier.dart';
import 'package:roadmap_ai/features/auth/presentation/providers/profile/profile_notifier.dart';
import 'package:roadmap_ai/features/auth/presentation/widgets/profile_field.dart';
import 'package:toastification/toastification.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileNotifier = ref.read(profileNotifierProvider.notifier);
    final profile = ref.watch(profileNotifierProvider);
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;
    final textTheme = context.textTheme;

    ref.listen(profileNotifierProvider, (_, next) {
      if (next is AsyncData && next.value?.error != null) {
        toastification.show(
          type: ToastificationType.error,
          title: Text('Error'),
          description: Text("${next.value?.error}"),
          autoCloseDuration: const Duration(seconds: 2),
        );
      }
    });

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
                                image: DecorationImage(
                                  image: NetworkImage(details.avatarUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
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
                        ref.read(logoutNotifierProvider.notifier).logout();
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
                        profileNotifier.refresh();
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
}
