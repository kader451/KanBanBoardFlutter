import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/projet_view_model.dart';
import '../models/projets.dart';
import 'components/project_title.dart';
import 'components/status_column.dart';
import 'components/create_project_dialog.dart';

class KanbanPage extends StatelessWidget {
  const KanbanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProjectsViewModel>();
    final Project? project = vm.currentProject;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 223, 164, 16),
        title: const Text("Kanban"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => CreateProjectDialog(
                  onConfirm: (name) => vm.createOrSetCurrentProject(name),
                ),
              );
            },
          ),
        ],
      ),

      body: project == null
          ? const Center(
              child: Text(
                "Clique sur + pour créer un projet.",
                textAlign: TextAlign.center,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ProjectTitle(title: project.name),
                  const SizedBox(height: 16),

                  Expanded(
                    child: Row(
                      children: const [
                        Expanded(
                          child: StatusColumn(
                            title: "À faire",
                            statusKey: "todo",
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: StatusColumn(
                            title: "En cours",
                            statusKey: "doing",
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: StatusColumn(
                            title: "À tester",
                            statusKey: "testing",
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: StatusColumn(
                            title: "Terminé",
                            statusKey: "done",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
