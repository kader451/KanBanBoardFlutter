// lib/view/kanban_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/projet_view_model.dart';

class KanbanPage extends StatelessWidget {
  const KanbanPage({super.key});

  @override
  Widget build(BuildContext context) {
    // On récupère le ViewModel (MVVM)
    final projectsViewModel = context.watch<ProjectsViewModel>();

    return Scaffold(
      // 🔹 Barre de navigation (AppBar) avec bouton "+"
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 223, 164, 16),
        title: const Text("Mes projets"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: "Créer un projet",
            onPressed: () {
              // Appel MVVM : la View demande au ViewModel de créer un projet
              projectsViewModel.createProject("Nouveau projet");
              // Pour le moment ça ne fait qu'ajouter en mémoire et logguer
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Projet créé (en mémoire)")),
              );
            },
          ),
        ],
      ),

      // 🔹 Corps : juste le grand rectangle pour le moment
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            width: double.infinity,
            height: 400,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.grey,
                width: 2,
              ),
            ),
            child: const Center(
              child: Text(
                "Ici tu ajouteras tes listes (À faire, En cours, Terminé...)",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
