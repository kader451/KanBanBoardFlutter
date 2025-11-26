class Task {
  final String id;
  final String projectId;
  final String title;
  final String? description;
  final String status;
  final DateTime? createdAt;

  Task({
    required this.id,
    required this.projectId,
    required this.title,
    this.description,
    required this.status,
    this.createdAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['_id'] as String,
      projectId: json['projectId'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      status: json['status'] as String,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'projectId': projectId,
      'title': title,
      'description': description,
      'status': status,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}
