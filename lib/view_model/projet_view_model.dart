import 'package:flutter/foundation.dart';

import '../models/projets.dart'; // classe Project
import '../models/taches.dart';  // classe Task
import '../services/api_service.dart';

class ProjectsViewModel extends ChangeNotifier {
  final ApiService _api = ApiService();

  Project? _currentProject;
  final List<Project> _projects = [];
  final List<Task> _tasks = [];

  // Projet courant
  Project? get currentProject => _currentProject;

  // Tous les projets
  List<Project> get allProjects => List.unmodifiable(_projects);

  // ------------------- API : CHARGER LES PROJETS -------------------

  /// Charge tous les projets depuis l'API et met à jour la liste locale.
  Future<void> loadProjectsFromApi() async {
    try {
      final apiProjects = await _api.fetchProjects();

      _projects
        ..clear()
        ..addAll(apiProjects);

      // Si aucun projet courant, on met le premier par défaut
      if (_projects.isNotEmpty && _currentProject == null) {
        _currentProject = _projects.first;
      }

      notifyListeners();
    } catch (e) {
      debugPrint('Erreur lors du chargement des projets depuis l’API: $e');
      // Tu peux aussi gérer un message d'erreur ici
    }
  }

  /// Charge les tâches du projet courant depuis l'API.
  Future<void> loadTasksForCurrentProject() async {
    if (_currentProject == null) return;

    try {
      final apiTasks =
          await _api.fetchTasksForProject(_currentProject!.id);

      // On enlève les anciennes tâches de ce projet
      _tasks.removeWhere((t) => t.projectId == _currentProject!.id);

      // On ajoute celles de l’API
      _tasks.addAll(apiTasks);

      notifyListeners();
    } catch (e) {
      debugPrint('Erreur lors du chargement des tâches depuis l’API: $e');
    }
  }

  // ------------------- LOGIQUE LOCALE (CRÉATION, DRAG, ETC.) -------------------

  void createOrSetCurrentProject(String name, {String? description}) {
    final newProject = Project(
      id: (_projects.length + 1).toString(),
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
    // On pourrait aussi charger ses tâches depuis l’API ici :
    // loadTasksForCurrentProject();
    notifyListeners();
  }

  // Tâches filtrées par statut pour le projet courant
  List<Task> tasksByStatus(String status) {
    if (_currentProject == null) return [];
    return _tasks
        .where((t) => t.projectId == _currentProject!.id && t.status == status)
        .toList();
  }

  // Ajouter une tâche (local pour l'instant)
  void addTask({
    required String title,
    String? description,
    required String status,
  }) {
    if (_currentProject == null) return;

    final newTask = Task(
      id: (_tasks.length + 1).toString(),
      projectId: _currentProject!.id,
      title: title,
      description: description,
      status: status,
    );

    _tasks.add(newTask);
    notifyListeners();
  }

  // Supprimer une tâche
  void deleteTask(String id) {
    _tasks.removeWhere((t) => t.id == id);
    notifyListeners();
  }

  // Déplacer une tâche vers un autre statut (drag & drop entre colonnes)
  void moveTaskToStatus(String taskId, String newStatus) {
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
