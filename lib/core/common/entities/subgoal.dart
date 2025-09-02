class SubgoalStatus {
  final bool completed;
  final DateTime? completedAt;
  final String id;

  const SubgoalStatus({
    required this.completed,
    this.completedAt,
    required this.id,
  });
}

class Subgoal {
  final String title;
  final String description;
  final String duration;
  final List<String> resources;
  final SubgoalStatus? status;
  final String id;

  const Subgoal({
    required this.title,
    required this.description,
    required this.duration,
    required this.resources,
    required this.status,
    required this.id,
  });
}
