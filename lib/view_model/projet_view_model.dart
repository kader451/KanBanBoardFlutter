import 'package:flutter/foundation.dart';
import '../models/projets.dart';
import '../models/taches.dart';

class ProjectsViewModel extends ChangeNotifier {
  Project? _currentProject;
  final List<Task> _tasks = [];

  Project? get currentProject => _currentProject;

  // Tâches filtrées par statut pour le projet courant
  List<Task> tasksByStatus(String status) {
    if (_currentProject == null) return [];
    return _tasks
        .where((t) => t.projectId == _currentProject!.id && t.status == status)
        .toList();
  }

  void createOrSetCurrentProject(String name, {String? description}) {
    _currentProject = Project(
      id: 1, // pour l’instant un seul projet
      name: name,
      description: description,
      isArchived: false,
    );

    // Optionnel : vider les tâches quand on change de projet
    // _tasks.clear();

    notifyListeners();
  }

  // Ajouter une tâche dans une colonne (statut)
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

  void deleteTask(int id) {
  _tasks.removeWhere((t) => t.id == id);
  notifyListeners();
}

}
