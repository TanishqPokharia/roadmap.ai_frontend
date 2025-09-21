import 'goal.dart';

class Roadmap {
  final String userId;
  final String title;
  final String description;
  final List<Goal> goals;
  final String id;

  const Roadmap({
    required this.userId,
    required this.title,
    required this.description,
    required this.goals,
    required this.id,
  });

  // make a copyWith method
  Roadmap copyWith({
    String? userId,
    String? title,
    String? description,
    List<Goal>? goals,
    String? id,
  }) {
    return Roadmap(
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      goals: goals ?? this.goals,
      id: id ?? this.id,
    );
  }
}
