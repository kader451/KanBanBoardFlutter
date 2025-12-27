import 'package:flutter/material.dart';
import 'kanban_page.dart';
import 'projects_list_page.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _index = 0;

  final List<Widget> _pages = const [
    KanbanPage(),      // Projet en cours
    ProjectsListPage() // Liste des projets
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Kanban",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: "Projets",
          ),
        ],
      ),
    );
  }
}
