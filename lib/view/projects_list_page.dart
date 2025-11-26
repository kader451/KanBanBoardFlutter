// lib/view/projects_list_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/projet_view_model.dart';
import '../models/projets.dart';

class ProjectsListPage extends StatelessWidget {
  const ProjectsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProjectsViewModel>();
    final List<Project> projects = vm.allProjects;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes projets'),
        backgroundColor: const Color.fromARGB(255, 223, 164, 16),
      ),
      body: projects.isEmpty
          ? const Center(
              child: Text(
                "Aucun projet.\nClique sur le bouton en bas pour charger depuis l'API.",
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects[index];

                return ListTile(
                  title: Text(project.name),
                  subtitle: project.description != null
                      ? Text(project.description!)
                      : null,
                  onTap: () {
                    // Quand on clique sur un projet :
                    // on le définit comme projet courant
                    vm.setCurrentProject(project);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Projet "${project.name}" sélectionné'),
                      ),
                    );
                  },
                );
              },
            ),

      // Bouton pour tester l'appel API
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color.fromARGB(255, 223, 164, 16),
        icon: const Icon(Icons.cloud_download),
        label: const Text("Charger depuis l'API"),
        onPressed: () async {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Chargement depuis l’API...')),
          );

          try {
            await vm.loadProjectsFromApi();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Projets chargés : ${vm.allProjects.length}'),
              ),
            );
          } catch (e) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Erreur API: $e')));
          }
        },
      ),
    );
  }
}
