import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadmap_ai/core/common/entities/goal.dart';
import 'package:roadmap_ai/core/common/entities/roadmap.dart';
import 'package:roadmap_ai/core/common/entities/subgoal.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/features/community/domain/entities/author.dart';
import 'package:roadmap_ai/features/community/domain/entities/post.dart';
import 'package:roadmap_ai/features/community/presentation/widgets/no_posts_widget.dart';
import 'package:roadmap_ai/features/community/presentation/widgets/post_stat_card.dart';
import 'package:roadmap_ai/features/community/presentation/widgets/your_post_tile.dart';

class YourPostsPage extends ConsumerWidget {
  const YourPostsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = context.textTheme;
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;

    // Dummy data for the user's posts
    final userPosts = _getDummyPosts();
    final postViews = _getDummyViews();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight * 0.04),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Posts',
                style: textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Manage and track your published roadmaps',
                style: textTheme.bodyLarge!.copyWith(color: Colors.blueGrey),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.03),

          // Stats summary section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: PostStatCard(
                  icon: Icons.article,
                  value: userPosts.length,
                  label: 'Posts',
                ),
              ),
              Expanded(
                child: PostStatCard(
                  icon: Icons.visibility,
                  value: postViews.values.reduce((a, b) => a + b),
                  label: 'Total Views',
                ),
              ),
              Expanded(
                child: PostStatCard(
                  icon: Icons.favorite,
                  value: userPosts.map((p) => p.likes).reduce((a, b) => a + b),
                  label: 'Total Likes',
                ),
              ),
            ],
          ),

          SizedBox(height: screenHeight * 0.03),

          Expanded(
            child: userPosts.isEmpty
                ? const NoPostsWidget()
                : Builder(
                    builder: (context) {
                      userPosts.sort(
                        (a, b) => b.createdAt.compareTo(a.createdAt),
                      );
                      return ListView.builder(
                        itemCount: userPosts.length,
                        itemBuilder: (context, index) {
                          final post = userPosts[index];
                          return YourPostTile(
                            post: post,
                            views: postViews[post.id] ?? 0,
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // Generate dummy posts for demonstration
  List<Post> _getDummyPosts() {
    final currentUser = Author(
      username: 'Your Username',
      email: 'you@example.com',
      avatar: 'https://example.com/avatar.jpg',
      id: 'user123',
    );

    return [
      Post(
        roadmap: Roadmap(
          id: 'roadmap1',
          userId: currentUser.id,
          title: 'Flutter Development for Beginners',
          description:
              'A comprehensive roadmap to learn Flutter development, covering basics to advanced topics.',
          goals: _getDummyGoals(),
        ),
        description:
            'A comprehensive roadmap for learning Flutter from scratch. Covers everything from basic widgets to advanced state management.',
        likes: 47,
        createdAt: DateTime.now().subtract(Duration(days: 14)),
        author: currentUser,
        id: 'post1',
        bannerUrl:
            'https://miro.medium.com/v2/resize:fit:1400/1*mDnoxKB-ZgHWw3NTZlZLDw.png',
      ),
      Post(
        roadmap: Roadmap(
          id: 'roadmap2',
          userId: currentUser.id,
          title: 'Machine Learning Career Path',
          description:
              'A comprehensive roadmap to learn machine learning, covering algorithms, tools, and best practices.',
          goals: _getDummyGoals(),
        ),
        description:
            'Everything you need to know to become a machine learning engineer. From Python basics to deploying ML models in production.',
        likes: 128,
        createdAt: DateTime.now().subtract(Duration(days: 28)),
        author: currentUser,
        id: 'post2',
        bannerUrl:
            'https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_Machine_Learning.jpg',
      ),
      Post(
        roadmap: Roadmap(
          id: 'roadmap3',
          userId: currentUser.id,
          title: 'Full-Stack Web Development',
          description:
              'A comprehensive roadmap to learn full-stack web development, covering frontend and backend technologies.',
          goals: _getDummyGoals(),
        ),
        description:
            'Learn to build modern web applications from frontend to backend. Covers HTML, CSS, JavaScript, React, Node.js, and databases.',
        likes: 94,
        createdAt: DateTime.now().subtract(Duration(days: 5)),
        author: currentUser,
        id: 'post3',
        bannerUrl:
            'https://149695847.v2.pressablecdn.com/wp-content/uploads/2022/09/full-stack-developer-roadmap.png',
      ),
    ];
  }

  // Generate dummy goals for roadmaps
  List<Goal> _getDummyGoals() {
    return [
      Goal(
        id: 'goal1',
        title: 'Fundamentals',
        subgoals: [
          Subgoal(
            id: 'subgoal1',
            title: 'Learn the basics',
            description: 'Get familiar with the core concepts',
            duration: '2 weeks',
            resources: ['Resource 1', 'Resource 2'],
            status: SubgoalStatus(
              id: 'status1',
              completed: true,
              completedAt: DateTime.now().subtract(Duration(days: 10)),
            ),
          ),
        ],
      ),
      Goal(
        id: 'goal2',
        title: 'Intermediate Concepts',
        subgoals: [
          Subgoal(
            id: 'subgoal2',
            title: 'Build your first project',
            description: 'Apply what you learned in a real project',
            duration: '3 weeks',
            resources: ['Resource 3', 'Resource 4'],
            status: null,
          ),
        ],
      ),
    ];
  }

  // Generate dummy view counts for posts
  Map<String, int> _getDummyViews() {
    return {'post1': 356, 'post2': 1247, 'post3': 83};
  }
}
