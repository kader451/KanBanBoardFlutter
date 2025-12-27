class Task {
  final int id;
  final int projectId;         // à quel projet cette tâche appartient
  final String title;
  final String? description;
  final String status;         // "todo", "doing", "testing", "done"

  Task({
    required this.id,
    required this.projectId,
    required this.title,
    this.description,
    required this.status,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as int,
      projectId: json['projectId'] as int,
      title: json['title'] as String,
      description: json['description'] as String?,
      status: json['status'] as String,
    );
  }
}
