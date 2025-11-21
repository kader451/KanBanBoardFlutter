import 'package:flutter/material.dart';
import '../../models/taches.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (task.description != null) ...[
              const SizedBox(height: 4),
              Text(
                task.description!,
                style: const TextStyle(fontSize: 12),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
