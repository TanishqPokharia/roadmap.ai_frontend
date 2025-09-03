import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roadmap_ai/core/common/entities/roadmap.dart';
import 'package:roadmap_ai/core/common/entities/goal.dart';
import 'package:roadmap_ai/core/common/entities/subgoal.dart';
import 'package:roadmap_ai/features/community/presentation/screens/post_page.dart';

part 'saved_roadmaps_notifier.g.dart';

@Riverpod(keepAlive: true)
class SavedRoadmapsNotifier extends _$SavedRoadmapsNotifier {
  @override
  FutureOr<List<Roadmap>> build() async {
    await Future.delayed(Duration(seconds: 2));

    // Create two more roadmaps in addition to the existing one
    final webDevelopmentRoadmap = Roadmap(
      id: 'roadmap2',
      userId: 'user123',
      title: 'Web Development Roadmap',
      description:
          'A comprehensive roadmap to learn full-stack web development, covering frontend and backend technologies.',
      goals: [
        Goal(
          id: 'web_goal1',
          title: 'Frontend Basics',
          subgoals: [
            Subgoal(
              id: 'web_subgoal1_1',
              title: 'HTML & CSS',
              description: 'Learn the fundamentals of HTML5 and CSS3',
              duration: '3 weeks',
              resources: [
                'https://www.w3schools.com/html/',
                'https://css-tricks.com/',
              ],
              status: SubgoalStatus(
                completed: true,
                completedAt: DateTime.now().subtract(const Duration(days: 45)),
                id: 'web_status1_1',
              ),
            ),
            Subgoal(
              id: 'web_subgoal1_2',
              title: 'JavaScript',
              description: 'Master JavaScript fundamentals and ES6+ features',
              duration: '4 weeks',
              resources: [
                'https://javascript.info/',
                'https://eloquentjavascript.net/',
              ],
              status: SubgoalStatus(completed: false, id: 'web_status1_2'),
            ),
          ],
        ),
        Goal(
          id: 'web_goal2',
          title: 'Frontend Frameworks',
          subgoals: [
            Subgoal(
              id: 'web_subgoal2_1',
              title: 'React',
              description: 'Learn React and its ecosystem',
              duration: '5 weeks',
              resources: ['https://reactjs.org/', 'https://reactrouter.com/'],
              status: SubgoalStatus(completed: false, id: 'web_status2_1'),
            ),
          ],
        ),
      ],
    );

    final machineLearningRoadmap = Roadmap(
      id: 'roadmap3',
      userId: 'user123',
      title: 'Machine Learning Roadmap',
      description:
          'A comprehensive roadmap to learn machine learning, covering algorithms, tools, and best practices.',
      goals: [
        Goal(
          id: 'ml_goal1',
          title: 'Mathematics Foundations',
          subgoals: [
            Subgoal(
              id: 'ml_subgoal1_1',
              title: 'Linear Algebra',
              description: 'Understand vectors, matrices, and transformations',
              duration: '3 weeks',
              resources: [
                'https://www.khanacademy.org/math/linear-algebra',
                'https://www.3blue1brown.com/topics/linear-algebra',
              ],
              status: SubgoalStatus(completed: true, id: 'ml_status1_1'),
            ),
            Subgoal(
              id: 'ml_subgoal1_2',
              title: 'Statistics & Probability',
              description: 'Learn statistical methods and probability theory',
              duration: '4 weeks',
              resources: [
                'https://www.statisticshowto.com/',
                'https://www.khanacademy.org/math/statistics-probability',
              ],
              status: SubgoalStatus(completed: false, id: 'ml_status1_2'),
            ),
          ],
        ),
        Goal(
          id: 'ml_goal2',
          title: 'ML Algorithms',
          subgoals: [
            Subgoal(
              id: 'ml_subgoal2_1',
              title: 'Supervised Learning',
              description: 'Study classification and regression algorithms',
              duration: '6 weeks',
              resources: [
                'https://scikit-learn.org/',
                'https://www.coursera.org/learn/machine-learning',
              ],
              status: SubgoalStatus(completed: false, id: 'ml_status2_1'),
            ),
          ],
        ),
      ],
    );

    return [roadmap, webDevelopmentRoadmap, machineLearningRoadmap];
  }
}
