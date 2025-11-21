import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/projet_view_model.dart';
import '../models/projets.dart';

class ProjectsListPage extends StatelessWidget {
  const ProjectsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProjectsViewModel>();
    final List<Project> projects = vm.allProjects; // On ajoute ca après

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tous mes projets"),
      ),
      body: projects.isEmpty
          ? const Center(
              child: Text(
                "Aucun projet pour l’instant.",
                textAlign: TextAlign.center,
              ),
            )
          : ListView.separated(
              itemCount: projects.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (_, index) {
                final p = projects[index];
                return ListTile(
                  title: Text(p.name),
                  subtitle:
                      p.description != null ? Text(p.description!) : null,
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Ouvrir ce projet
                    vm.setCurrentProject(p);
                    Navigator.pop(context);
                  },
                );
              },
            ),
    );
  }
}
