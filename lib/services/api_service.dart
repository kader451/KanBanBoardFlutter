import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/projets.dart';
import '../models/taches.dart';
import 'endpoints.dart';

class ApiService {
  final http.Client _client;

  ApiService({http.Client? client}) : _client = client ?? http.Client();


  //   ||||||||||||||||||||||||||PROJECTS|||||||||||||||||||||||||||||||--
 

  /// Récupèrer la liste de tous les projets
  Future<List<Project>> fetchProjects() async {
    final uri = Uri.parse(ApiEndpoints.projects);
    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;

      return data
          .map((json) => Project.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception(
        'Erreur lors du chargement des projets (code ${response.statusCode})',
      );
    }
  }

  /// Cree un nouveau Projet
  Future<Project> createProject({
    required String name,
    String? description,
  }) async {
    final uri = Uri.parse(ApiEndpoints.projects);

    final response = await _client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'description': description,
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;

      return Project.fromJson(data);
    } else {
      throw Exception(
        'Erreur lors de la création du projet (code ${response.statusCode})',
      );
    }
  }

  //  |||||||||||||||||||||||||||||||TASKS||||||||||||||||||||||||||||||||||
  

  /// Récupèrer toutes les tâches 
  Future<List<Task>> fetchTasksForProject(String projectId) async {
    final uri = Uri.parse(ApiEndpoints.tasksByProject(projectId));

    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;

      return data
          .map((json) => Task.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception(
        'Erreur lors du chargement des tâches (code ${response.statusCode})',
      );
    }
  }

  /// Crée une nouvelle tache 
  Future<Task> createTask({
    required String projectId,
    required String title,
    String? description,
    required String status,
  }) async {
    final uri = Uri.parse(ApiEndpoints.tasksByProject(projectId));

    final response = await _client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': title,
        'description': description,
        'status': status,
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;

      return Task.fromJson(data);
    } else {
      throw Exception(
        'Erreur lors de la création de la tâche (code ${response.statusCode})',
      );
    }
  }

  /// Met à jour le statut d'une tâche.
  Future<void> updateTaskStatus({
    required String taskId,
    required String newStatus,
  }) async {
    final uri = Uri.parse(ApiEndpoints.taskById(taskId));

    final response = await _client.patch(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'status': newStatus}),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Erreur lors de la mise à jour du statut (code ${response.statusCode})',
      );
    }
  }


// Pour supprimer une tache
  Future<void> deleteTask(String taskId) async {
    final uri = Uri.parse(ApiEndpoints.taskById(taskId));

    final response = await _client.delete(uri);

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception(
        'Erreur lors de la suppression de la tâche (code ${response.statusCode})',
      );
    }
  }
}
