class Task {
  final int id;
  final String title;
  final String? description;
  final String status; 

  Task({
    required this.id,
    required this.title,
    this.description,
    required this.status,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String?,
      status: json['status'] as String,
    );
  }
}
