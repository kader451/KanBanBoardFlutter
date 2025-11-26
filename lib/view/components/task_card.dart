import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/taches.dart';
import '../../view_model/projet_view_model.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback? onDelete;

  const TaskCard({
    super.key,
    required this.task,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2, 
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      child: InkWell(
        onLongPress: onDelete, 
        child: Padding(
          padding: const EdgeInsets.all(12.0), 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Affiche le titre d'une tache
              Text(
                task.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              // La description si elle est presente 
              if (task.description != null && task.description!.isNotEmpty)
                Text(
                  task.description!,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),

              const SizedBox(height: 10),

           
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  key: const Key("deleteButton"),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                  onPressed: onDelete ??
                      () {
                        context
                            .read<ProjectsViewModel>()
                            .deleteTask(task.id);
                      },
                  child: const Text("Supprimer"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
