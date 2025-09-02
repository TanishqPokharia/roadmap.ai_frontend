import 'package:flutter/material.dart';
import 'package:roadmap_ai/core/extensions/responsive_extensions.dart';
import 'package:roadmap_ai/core/extensions/theme_extensions.dart';
import 'package:roadmap_ai/core/common/entities/goal.dart';
import 'package:roadmap_ai/core/common/entities/roadmap.dart';
import 'package:roadmap_ai/core/common/entities/subgoal.dart';
import 'package:roadmap_ai/features/community/presentation/widgets/roadmap_tree.dart';

final roadmap = Roadmap(
  id: 'postId',
  userId: 'user123',
  title: 'Flutter Development Roadmap',
  goals: [
    Goal(
      id: 'goal1',
      title: 'Learn Flutter Basics',
      subgoals: [
        Subgoal(
          id: 'subgoal1_1',
          title: 'Dart Programming',
          description: 'Learn Dart syntax and concepts',
          duration: '2 weeks',
          resources: [
            'https://dart.dev/guides',
            'https://www.udemy.com/course/dart-programming/',
          ],
          status: SubgoalStatus(
            completed: true,
            completedAt: DateTime.now().subtract(const Duration(days: 30)),
            id: 'status1_1',
          ),
        ),
        Subgoal(
          id: 'subgoal1_2',
          title: 'Widget Basics',
          description: 'Understand stateful and stateless widgets',
          duration: '3 weeks',
          resources: ['https://flutter.dev/docs/development/ui/widgets-intro'],
          status: SubgoalStatus(
            completed: true,
            completedAt: DateTime.now().subtract(const Duration(days: 15)),
            id: 'status1_2',
          ),
        ),
      ],
    ),
    Goal(
      id: 'goal2',
      title: 'State Management',
      subgoals: [
        Subgoal(
          id: 'subgoal2_1',
          title: 'Provider',
          description: 'Implement provider pattern',
          duration: '1 week',
          resources: [
            'https://pub.dev/packages/provider',
            'https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple',
          ],
          status: SubgoalStatus(completed: false, id: 'status2_1'),
        ),
        Subgoal(
          id: 'subgoal2_2',
          title: 'Bloc/Cubit',
          description: 'Understand reactive programming with Bloc',
          duration: '2 weeks',
          resources: [
            'https://bloclibrary.dev/',
            'https://pub.dev/packages/flutter_bloc',
          ],
          status: SubgoalStatus(completed: false, id: 'status2_2'),
        ),
      ],
    ),
    Goal(
      id: 'goal3',
      title: 'Advanced Flutter',
      subgoals: [
        Subgoal(
          id: 'subgoal3_1',
          title: 'Animations',
          description: 'Create complex UI animations',
          duration: '3 weeks',
          resources: [
            'https://flutter.dev/docs/development/ui/animations',
            'https://flutter.dev/docs/development/ui/animations/tutorial',
          ],
          status: SubgoalStatus(completed: false, id: 'status3_1'),
        ),
        Subgoal(
          id: 'subgoal3_2',
          title: 'Custom Painting',
          description: 'Learn to create custom UI with Canvas',
          duration: '2 weeks',
          resources: [
            'https://flutter.dev/docs/development/ui/advanced/custom_paint',
          ],
          status: SubgoalStatus(completed: false, id: 'status3_2'),
        ),
      ],
    ),
  ],
);

class PostPage extends StatelessWidget {
  const PostPage({super.key, required this.postId, required this.title});
  final String postId;
  final String title;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;
    final colorScheme = context.colorScheme;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: screenHeight * 0.05,
          right: screenWidth * 0.05,
          left: screenWidth * 0.05,
        ),
        child: SingleChildScrollView(
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
              Row(
                children: [
                  Row(
                    children: [
                      Text(
                        'Posted by ',
                        style: textTheme.bodyMedium!.copyWith(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'John Doe',
                        style: textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          color: colorScheme.primary,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.01),
                      ClipOval(
                        child: Image.network(
                          "https://images.squarespace-cdn.com/content/v1/58c9706f9f7456a4a142c10c/1507640476287-41GORCK3VY3BD0MLRTIZ/success-man-small1.jpg",
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.01),
                      Text(
                        'on 25th December 2022',
                        style: textTheme.bodyMedium!.copyWith(
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
                          IconButton.filled(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                colorScheme.primary.withAlpha(30),
                              ),
                              shape: WidgetStatePropertyAll(CircleBorder()),
                            ),
                            icon: Icon(Icons.favorite, color: Colors.pink),
                          ),
                          Text(
                            '124',
                            style: textTheme.bodyMedium!.copyWith(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: screenWidth * 0.01),
                      Column(
                        spacing: 5,
                        children: [
                          IconButton.filled(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                colorScheme.primary.withAlpha(30),
                              ),
                              shape: WidgetStatePropertyAll(CircleBorder()),
                            ),
                            icon: Icon(Icons.bookmark, color: Colors.blue),
                          ),
                          Text(
                            'Saved',
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
              SizedBox(height: screenHeight * 0.02),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    'https://external-preview.redd.it/H274VHAVhBDAMYXE0hynj5ylw7kTsRZPw-HLb1alalU.jpg?width=1080&crop=smart&auto=webp&s=08af2e4c724fd5fe0e558b58fd8bd3438468890b',
                    height: screenWidth * 0.25,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Center(
                child: SizedBox(
                  width: screenWidth / 2,
                  child: Text(
                    "Laboris ullamco Lorem dolore laborum id ex quis laborum dolore dolore. Reprehenderit culpa ullamco eu tempor adipisicing cupidatat nostrud excepteur amet do reprehenderit ex eiusmod. Ullamco officia ullamco do ex anim sit do et Lorem. Sunt aute reprehenderit velit exercitation excepteur eu sunt ea culpa mollit labore. Officia velit exercitation veniam velit ullamco id eiusmod eiusmod ullamco sit laboris ea mollit. Exercitation magna nisi occaecat in anim est amet veniam. Quis irure magna Lorem dolore in.",
                    style: textTheme.bodyMedium!.copyWith(
                      color: Colors.blueGrey,
                    ),
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
                child: RoadmapTree(roadmap: roadmap),
              ),
              SizedBox(height: screenHeight * 0.1),
            ],
          ),
        ),
      ),
    );
  }
}
