import 'subgoal.dart';

class Goal {
  final String title;
  final List<Subgoal> subgoals;
  final String id;

  const Goal({required this.title, required this.subgoals, required this.id});

  // a copyWith method
  Goal copyWith({String? title, List<Subgoal>? subgoals, String? id}) {
    return Goal(
      title: title ?? this.title,
      subgoals: subgoals ?? this.subgoals,
      id: id ?? this.id,
    );
  }
}
