// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view/kanban_page.dart';
import './view_model/projet_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProjectsViewModel(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

// Widget racine de l'application
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
      home: const KanbanPage(),
    );
  }
}
