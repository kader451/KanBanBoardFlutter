import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'view/main_navigation.dart';               // ou kanban_page.dart
import 'view_model/projet_view_model.dart';       // <-- IMPORTANT

void main() {
  runApp(
    ChangeNotifierProvider<ProjectsViewModel>(
      create: (context) => ProjectsViewModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainNavigation(),   // ou KanbanPage()
    );
  }
}
