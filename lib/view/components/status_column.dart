import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/taches.dart';
import '../../view_model/projet_view_model.dart';
import 'task_card.dart';
import 'create_task_dialog.dart';

/// Données transportées pendant le drag
class TaskDragData {
  final int taskId;
  final String fromStatus;

  TaskDragData({
    required this.taskId,
    required this.fromStatus,
  });
}

class StatusColumn extends StatelessWidget {
  final String title;     // ex: "À faire"
  final String statusKey; // ex: "todo", "doing", "testing", "done"

  const StatusColumn({
    super.key,
    required this.title,
    required this.statusKey,
  });

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProjectsViewModel>();
    final List<Task> tasks = vm.tasksByStatus(statusKey);

    return DragTarget<TaskDragData>(
      onWillAcceptWithDetails: (details) {
        // On accepte toujours, même si ça vient de la même colonne
        return true;
      },
      onAcceptWithDetails: (details) {
        final data = details.data;
        // On demande simplement au ViewModel de changer le statut
        // Seulement si on change de colonne
        if (data.fromStatus != statusKey) {
          vm.moveTaskToStatus(data.taskId, statusKey);
        }
      },
      builder: (context, candidateData, rejectedData) {
        final isHighlighted = candidateData.isNotEmpty;

        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isHighlighted ? Colors.blue.shade50 : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: Column(
            children: [
              // Titre + bouton +
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, size: 20),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => CreateTaskDialog(
                          onConfirm: (t, d) {
                            vm.addTask(
                              title: t,
                              description: d,
                              status: statusKey,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Liste des étiquettes draggables
              Expanded(
                child: tasks.isEmpty
                    ? const Center(
                        child: Text(
                          "Aucune étiquette",
                          style: TextStyle(fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : ListView.separated(
                        itemCount: tasks.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: 6),
                        itemBuilder: (context, index) {
                          final task = tasks[index];

                          return Draggable<TaskDragData>(
                            data: TaskDragData(
                              taskId: task.id,
                              fromStatus: statusKey,
                            ),
                            feedback: Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(8),
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 220,
                                ),
                                child: TaskCard(task: task),
                              ),
                            ),
                            childWhenDragging: Opacity(
                              opacity: 0.4,
                              child: TaskCard(task: task),
                            ),
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              child: TaskCard(task: task),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
