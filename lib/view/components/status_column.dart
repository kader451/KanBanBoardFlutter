
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/taches.dart';
import '../../view_model/projet_view_model.dart';
import 'task_card.dart';
import 'create_task_dialog.dart';


class TaskDragData {
  final String taskId;
  final String fromStatus;

  TaskDragData({required this.taskId, required this.fromStatus});
}

class StatusColumn extends StatelessWidget {
  final String title; 
  final String statusKey; 

  const StatusColumn({super.key, required this.title, required this.statusKey});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProjectsViewModel>();
    final List<Task> tasks = vm.tasksByStatus(statusKey);

return DragTarget<TaskDragData>(
  onWillAcceptWithDetails: (details) {
    return true;
  },
  onAcceptWithDetails: (details) {
    final data = details.data;

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
        border: Border.all(
          color: isHighlighted ? Colors.blue : Colors.grey.shade400,
          width: isHighlighted ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
// |||||||||||||||||||||||||||||||||TITRE AVEC LE BOUTON||||||||||||||||||||
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
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

// |||||||||||||||||||||||||||||||||LISTE DES TÂCHES||||||||||||||||||||

              Expanded(
                child: tasks.isEmpty
                    ? const Center(
                        child: Text(
                          "Aucune tâche",
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          final task = tasks[index];

                          // Chaque Tache est draggable
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
                                  maxWidth: 260,
                                ),
                                child: TaskCard(task: task),
                              ),
                            ),
                            childWhenDragging: Opacity(
                              opacity: 0.4,
                              child: TaskCard(
                                task: task,
                                onDelete: () => vm.deleteTask(task.id),
                              ),
                            ),
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              child: TaskCard(
                                task: task,
                                onDelete: () => vm.deleteTask(task.id),
                              ),
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
