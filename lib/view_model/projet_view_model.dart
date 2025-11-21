// lib/viewmodel/projects_view_model.dart
import 'package:flutter/foundation.dart';
import '../models/projets.dart'; // ton modèle Project simplifié

class ProjectsViewModel extends ChangeNotifier {
  final List<Project> _projects = [];

  List<Project> get projects => List.unmodifiable(_projects);

  // Méthode appelée quand on clique sur le bouton "+"
  void createProject(String name, {String? description}) {
    final newProject = Project(
      id: _projects.length + 1, // simple auto-incrément pour l'instant
      name: name,
      description: description,
      isArchived: false,
    );

    _projects.add(newProject);
    notifyListeners();

    debugPrint('Projet créé: ${newProject.name}');
  }
}
