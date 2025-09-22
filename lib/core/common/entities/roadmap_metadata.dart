class RoadmapMetadata {
  final String id;
  final String title;
  final String description;
  final int goalsCount;
  final int subgoalsCount;
  final bool isPosted;
  final int completedSubgoals;

  RoadmapMetadata({
    required this.id,
    required this.title,
    required this.description,
    required this.goalsCount,
    required this.subgoalsCount,
    required this.completedSubgoals,
    required this.isPosted,
  });

  RoadmapMetadata copyWith({
    String? id,
    String? title,
    String? description,
    int? goalsCount,
    int? subgoalCount,
    int? completedSubgoals,
    bool? isPosted,
  }) {
    return RoadmapMetadata(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      goalsCount: goalsCount ?? this.goalsCount,
      subgoalsCount: subgoalCount ?? subgoalsCount,
      completedSubgoals: completedSubgoals ?? this.completedSubgoals,
      isPosted: isPosted ?? this.isPosted,
    );
  }
}
