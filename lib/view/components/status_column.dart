import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/taches.dart';
import '../../view_model/projet_view_model.dart';
import 'task_card.dart';
import 'create_task_dialog.dart';

class StatusColumn extends StatelessWidget {
  final String title; // "À faire"
  final String statusKey; // "todo"

  const StatusColumn({super.key, required this.title, required this.statusKey});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProjectsViewModel>();
    final List<Task> tasks = vm.tasksByStatus(statusKey);

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Column(
        children: [
          // Titre + bouton +
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              IconButton(
                icon: const Icon(Icons.add, size: 20),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => CreateTaskDialog(
                      onConfirm: (t, d) {
                        vm.addTask(title: t, description: d, status: statusKey);
                      },
                    ),
                  );
                },
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Liste des étiquettes
          Expanded(
            child: tasks.isEmpty
                ? const Center(
                    child: Text(
                      "Aucune étiquette",
                      style: TextStyle(fontSize: 12),
                    ),
                  )
                : ListView.separated(
                    itemCount: tasks.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 6),
                    itemBuilder: (_, index) => TaskCard(task: tasks[index]),
                  ),
          ),
        ],
      ),
    );
  }
}
