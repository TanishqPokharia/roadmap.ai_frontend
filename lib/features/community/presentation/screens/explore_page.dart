import 'package:flutter/material.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/features/community/domain/entities/author.dart';
import 'package:roadmap_ai/features/community/domain/entities/post.dart';
import 'package:roadmap_ai/core/common/entities/roadmap.dart';
import 'package:roadmap_ai/features/community/presentation/widgets/post_tile.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;
    return Padding(
      padding: EdgeInsets.only(left: screenWidth * 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight * 0.04),
          Column(
            spacing: screenHeight * 0.01,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Roadmaps',
                style: textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Explore community created roadmaps',
                style: textTheme.bodyLarge!.copyWith(color: Colors.blueGrey),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.05),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                child: PostTile(
                  post: Post(
                    description:
                        'Learn how to scrape data from websites using Python.',
                    roadmap: Roadmap(
                      title: 'Web Scraping in Python Roadmap',
                      userId: '12345',
                      goals: [],
                      id: '1',
                    ),
                    likes: 124,
                    createdAt: DateTime.now(),
                    author: Author(
                      username: 'John Doe',
                      email: 'john@example.com',
                      avatar: 'https://example.com/profile.jpg',
                      id: '1',
                    ),
                    id: '1',
                    bannerUrl:
                        'https://external-preview.redd.it/H274VHAVhBDAMYXE0hynj5ylw7kTsRZPw-HLb1alalU.jpg?width=1080&crop=smart&auto=webp&s=08af2e4c724fd5fe0e558b58fd8bd3438468890b',
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.05),
        ],
      ),
    );
  }
}
