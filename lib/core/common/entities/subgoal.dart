class SubgoalStatus {
  final bool completed;
  final DateTime? completedAt;
  final String id;

  const SubgoalStatus({
    required this.completed,
    this.completedAt,
    required this.id,
  });

  // a copyWith method
  SubgoalStatus copyWith({
    bool? isCompleted,
    DateTime? completedAt,
    String? id,
  }) {
    return SubgoalStatus(
      completed: isCompleted ?? completed,
      completedAt: completedAt ?? this.completedAt,
      id: id ?? this.id,
    );
  }
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

  // a copyWith method
  Subgoal copyWith({
    String? title,
    String? description,
    String? duration,
    List<String>? resources,
    SubgoalStatus? status,
    String? id,
  }) {
    return Subgoal(
      title: title ?? this.title,
      description: description ?? this.description,
      duration: duration ?? this.duration,
      resources: resources ?? this.resources,
      status: status ?? this.status,
      id: id ?? this.id,
    );
  }
}
