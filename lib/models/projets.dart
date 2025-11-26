class Project {
  final String id;
  final String name;
  final String? description;
  final DateTime? createdAt;
  final bool isArchived;

  Project({
    required this.id,
    required this.name,
    this.description,
    this.createdAt,
    this.isArchived = false,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
      isArchived: json['isArchived'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'createdAt': createdAt?.toIso8601String(),
      'isArchived': isArchived,
    };
  }
}
