// lib/main.dart
import 'package:flutter/material.dart';
// 🔽 importe directement ta page principale (Kanban ou autre)
import 'view/kanban_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      // 🔽 On démarre directement sur UNE page
      home: const KanbanPage(),
    );
  }
}
