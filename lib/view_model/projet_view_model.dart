import 'package:flutter/foundation.dart';
import '../models/projets.dart'; // classe Project
import '../models/taches.dart'; // classe Task

class ProjectsViewModel extends ChangeNotifier {
  Project? _currentProject;
  final List<Project> _projects = [];
  final List<Task> _tasks = [];

  // Projet courant
  Project? get currentProject => _currentProject;

  // Tous les projets
  List<Project> get allProjects => List.unmodifiable(_projects);

  // Créer un nouveau projet et le définir comme courant
  void createOrSetCurrentProject(String name, {String? description}) {
    final newProject = Project(
      id: _projects.length + 1,
      name: name,
      description: description,
    );

    _projects.add(newProject);
    _currentProject = newProject;

    notifyListeners();
  }

  // Changer de projet courant
  void setCurrentProject(Project project) {
    _currentProject = project;
    notifyListeners();
  }

  // Tâches filtrées par statut pour le projet courant
  List<Task> tasksByStatus(String status) {
    if (_currentProject == null) return [];
    return _tasks
        .where((t) => t.projectId == _currentProject!.id && t.status == status)
        .toList();
  }

  // Ajouter une tâche dans un statut donné
  void addTask({
    required String title,
    String? description,
    required String status,
  }) {
    if (_currentProject == null) return;

    final newTask = Task(
      id: _tasks.length + 1,
      projectId: _currentProject!.id,
      title: title,
      description: description,
      status: status,
    );

    _tasks.add(newTask);
    notifyListeners();
  }

  // Supprimer une tâche
  void deleteTask(int id) {
    _tasks.removeWhere((t) => t.id == id);
    notifyListeners();
  }

  // 🔹 Déplacer une tâche vers une autre colonne (changer de statut)
  void moveTaskToStatus(int taskId, String newStatus) {
    final index = _tasks.indexWhere((t) => t.id == taskId);
    if (index == -1) return;

    final old = _tasks[index];

    final updated = Task(
      id: old.id,
      projectId: old.projectId,
      title: old.title,
      description: old.description,
      status: newStatus,
    );

    _tasks[index] = updated;
    notifyListeners();
  }
}
