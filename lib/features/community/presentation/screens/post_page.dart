import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:roadmap_ai/core/common/toast/error.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/core/utils/format_date.dart';
import 'package:roadmap_ai/features/community/presentation/providers/post_details/post_details_notifier.dart';
import 'package:roadmap_ai/features/community/presentation/widgets/roadmap_tree.dart';

class PostPage extends ConsumerWidget {
  const PostPage({super.key, required this.postId, required this.title});
  final String postId;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = context.textTheme;
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;
    final colorScheme = context.colorScheme;
    final postDetails = ref.watch(postDetailsProvider(postId));

    ref.listen(postDetailsProvider(postId), (_, next) {
      if (next is AsyncData<PostDetailsState> && next.value.error != null) {
        showErrorToast(context: context, error: "${next.value.error}");
      }
    });

    if (!kIsWeb && Platform.isAndroid) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: postDetails.when(
              loading: () => Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) {
                return Center(
                  child: Text(
                    'Error loading post: $error',
                    style: textTheme.bodyLarge!.copyWith(color: Colors.red),
                  ),
                );
              },
              data: (data) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back_ios),
                            onPressed: () => context.pop(),
                          ),
                          Expanded(
                            child: Text(
                              title,
                              style: textTheme.headlineSmall!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Posted by ',
                                style: textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                data.postDetails.post.author.username,
                                style: textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.primary,
                                ),
                              ),
                              SizedBox(width: 10),
                              CircleAvatar(
                                radius: 24,
                                backgroundColor: colorScheme.primary,
                                backgroundImage:
                                    data.postDetails.post.author.avatar != null
                                    ? NetworkImage(
                                        data.postDetails.post.author.avatar!,
                                      )
                                    : null,
                                child:
                                    data.postDetails.post.author.avatar == null
                                    ? Icon(Icons.person, color: Colors.white)
                                    : null,
                              ),
                            ],
                          ),
                          Text(
                            'on ${formatDate(data.postDetails.post.createdAt)}',
                            style: textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.primary,
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            data.postDetails.post.bannerImage,
                            fit: BoxFit.cover,
                            height: 200,
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 10,
                        children: [
                          Column(
                            spacing: 5,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: colorScheme.primary.withAlpha(30),
                                  shape: BoxShape.circle,
                                ),
                                padding: EdgeInsets.all(16),
                                child: Icon(Icons.favorite, color: Colors.pink),
                              ),
                              Text(
                                data.postDetails.post.likes.toString(),
                                style: textTheme.bodyMedium!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: screenWidth * 0.01),
                          if (data.postDetails.isSaved)
                            Column(
                              spacing: 5,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: colorScheme.primary.withAlpha(30),
                                    shape: BoxShape.circle,
                                  ),
                                  padding: EdgeInsets.all(16),
                                  child: Icon(
                                    Icons.bookmark,
                                    color: Colors.blue,
                                  ),
                                ),
                                Text(
                                  'Saved',
                                  style: textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          else
                            Column(
                              spacing: 5,
                              children: [
                                InkWell(
                                  onTap: () {
                                    ref
                                        .read(
                                          postDetailsProvider(postId).notifier,
                                        )
                                        .savePostRoadmap(postId);
                                  },
                                  borderRadius: BorderRadius.circular(100),
                                  hoverColor: colorScheme.primary,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: colorScheme.primary.withAlpha(30),
                                      shape: BoxShape.circle,
                                    ),
                                    padding: EdgeInsets.all(16),
                                    child: Icon(
                                      Icons.bookmark_outline,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Save',
                                  style: textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.05),
                      Center(
                        child: SizedBox(
                          child: Text(
                            data.postDetails.post.description,
                            style: textTheme.titleMedium?.copyWith(),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child: Text(
                          'Roadmap',
                          style: textTheme.headlineMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(),
                        child: RoadmapTree(
                          roadmap: data.postDetails.post.roadmap,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.1),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: screenHeight * 0.05,
          right: screenWidth * 0.05,
          left: screenWidth * 0.05,
        ),
        child: postDetails.when(
          loading: () => Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) {
            return Center(
              child: Text(
                'Error loading post: $error',
                style: textTheme.bodyLarge!.copyWith(color: Colors.red),
              ),
            );
          },
          data: (data) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Roadmaps / ',
                      style: textTheme.titleMedium!.copyWith(
                        color: Colors.blueGrey,
                      ),
                      children: [
                        TextSpan(text: title, style: textTheme.titleMedium),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    title,
                    style: textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.02,
                    ),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Posted by ',
                              style: textTheme.bodyLarge!.copyWith(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              data.postDetails.post.author.username,
                              style: textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.primary,
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.004),
                            CircleAvatar(
                              radius: screenWidth * 0.015,
                              backgroundColor: colorScheme.primary,
                              backgroundImage:
                                  data.postDetails.post.author.avatar != null
                                  ? NetworkImage(
                                      data.postDetails.post.author.avatar!,
                                    )
                                  : null,
                              child: data.postDetails.post.author.avatar == null
                                  ? Icon(Icons.person, color: Colors.white)
                                  : null,
                            ),
                            SizedBox(width: screenWidth * 0.004),
                            Text(
                              'on ${formatDate(data.postDetails.post.createdAt)}',
                              style: textTheme.bodyLarge!.copyWith(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        Row(
                          spacing: 10,
                          children: [
                            Column(
                              spacing: 5,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: colorScheme.primary.withAlpha(30),
                                    shape: BoxShape.circle,
                                  ),
                                  padding: EdgeInsets.all(16),
                                  child: Icon(
                                    Icons.favorite,
                                    color: Colors.pink,
                                  ),
                                ),
                                Text(
                                  data.postDetails.post.likes.toString(),
                                  style: textTheme.bodyMedium!.copyWith(
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: screenWidth * 0.01),
                            if (data.postDetails.isSaved)
                              Column(
                                spacing: 5,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: colorScheme.primary.withAlpha(30),
                                      shape: BoxShape.circle,
                                    ),
                                    padding: EdgeInsets.all(16),
                                    child: Icon(
                                      Icons.bookmark,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  Text(
                                    'Saved',
                                    style: textTheme.bodyMedium!.copyWith(
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                            else
                              Column(
                                spacing: 5,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      ref
                                          .read(
                                            postDetailsProvider(
                                              postId,
                                            ).notifier,
                                          )
                                          .savePostRoadmap(postId);
                                    },
                                    borderRadius: BorderRadius.circular(100),
                                    hoverColor: colorScheme.primary,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: colorScheme.primary.withAlpha(
                                          30,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      padding: EdgeInsets.all(16),
                                      child: Icon(
                                        Icons.bookmark_outline,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Save',
                                    style: textTheme.bodyMedium!.copyWith(
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        data.postDetails.post.bannerImage,
                        height: screenWidth * 0.2,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  Center(
                    child: SizedBox(
                      width: screenWidth / 2,
                      child: Text(
                        data.postDetails.post.description,
                        style: textTheme.titleMedium,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth / 5,
                      top: screenWidth * 0.02,
                    ),
                    child: Text(
                      'Roadmap',
                      style: textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    width: screenWidth / 2,
                    margin: EdgeInsets.only(
                      top: screenWidth * 0.04,
                      left: screenWidth / 5,
                    ),
                    child: RoadmapTree(roadmap: data.postDetails.post.roadmap),
                  ),
                  SizedBox(height: screenHeight * 0.1),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
