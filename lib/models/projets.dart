class Project {
  final int id;
  final String name;
  final String? description;
  final bool isArchived;

  Project({
    required this.id,
    required this.name,
    this.description,
    this.isArchived = false,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      isArchived: json['isArchived'] as bool? ?? false,
    );
  }
}
