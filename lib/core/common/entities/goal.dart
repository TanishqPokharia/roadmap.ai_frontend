import 'subgoal.dart';

class Goal {
  final String title;
  final List<Subgoal> subgoals;
  final String id;

  const Goal({required this.title, required this.subgoals, required this.id});
}
