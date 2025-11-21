import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/taches.dart';
import '../../view_model/projet_view_model.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            // Contenu principal
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                if (task.description != null) ...[
                  const SizedBox(height: 4),
                  Text(task.description!, style: const TextStyle(fontSize: 12)),
                ],
              ],
            ),

            // Bouton supprimer (en haut à droite)
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () {
                  context.read<ProjectsViewModel>().deleteTask(task.id);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
