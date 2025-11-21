class Task {
  final int id;
  final String title;
  final String? description;
  final int projectId;
  final String status; // "todo", "doing", "done"

  Task({
    required this.id,
    required this.title,
    this.description,
    required this.projectId,
    required this.status,
  });

  // Factory pour créer une Task depuis du JSON
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String?,
      projectId: json['projectId'] as int,
      status: json['status'] as String,
    );
  }
}
