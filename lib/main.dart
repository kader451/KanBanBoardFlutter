import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'view/main_navigation.dart';
import 'view_model/projet_view_model.dart';

void main() {
  runApp(
    // Provider
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ProjectsViewModel>(
          create: (_) => ProjectsViewModel(),
        ),
      ],
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
      title: 'Kanban Board',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainNavigation(),
    );
  }
}
