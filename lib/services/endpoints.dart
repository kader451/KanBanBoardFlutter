import 'package:flutter/foundation.dart';


class ApiEndpoints {
  static const String _webBase = 'http://localhost:3000';
  static const String _androidEmuBase = 'http://10.0.2.2:3000';

  static String get baseUrl => kIsWeb ? _webBase : _androidEmuBase;


  static String get projects => '$baseUrl/projects';

  static String get tasks => '$baseUrl/tasks';


  static String projectById(String projectId) => '$baseUrl/projects/$projectId';

  static String tasksByProject(String projectId) =>
      '$baseUrl/projects/$projectId/tasks';

  static String taskById(String taskId) => '$baseUrl/tasks/$taskId';
}
