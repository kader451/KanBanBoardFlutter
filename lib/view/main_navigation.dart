import 'package:flutter/material.dart';
import 'kanban_page.dart';
import 'projects_page.dart';
import 'archived_projects_page.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {

  // Index de l’onglet sélectionné
  int _selectedIndex = 0;

  // Liste des pages correspondant aux onglets
  final List<Widget> _pages = const [
    KanbanPage(),          // Index 0 → Kanban
    ProjectsPage(),        // Index 1 → Liste des projets
    ArchivedProjectsPage() // Index 2 → Projets archivés
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barre du haut
      appBar: AppBar(
        // Titre dynamique selon l'onglet actuel
        title: Text(
          switch (_selectedIndex) {
            0 => "Kanban Board",
            1 => "Projets",
            2 => "Archives",
            _ => "Kanban Board",
          },
        ),

        actions: [
          // Bouton pour AFFICHER les archives
          // --> ce n'est PAS pour archiver
          IconButton(
            icon: const Icon(Icons.archive),
            tooltip: "Voir les projets archivés",
            onPressed: () {
              setState(() {
                _selectedIndex = 2; // Ouvrir l’onglet "Archives"
              });
            },
          ),
        ],
      ),

      // Corps de la page correspondant à l’onglet
      body: _pages[_selectedIndex],

      // Le bouton "+" n'apparaît que sur la page "Projets"
      floatingActionButton: _selectedIndex == 1
          ? FloatingActionButton(
              onPressed: () {
                // Logique pour créer un projet
                debugPrint("Créer un nouveau projet");
              },
              child: const Icon(Icons.add),
            )
          : null,

      // Barre de navigation du bas
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,        // Onglet actif
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,

        // Changement d’onglet quand on clique
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.view_kanban),
            label: "Kanban",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: "Projets",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive_outlined),
            label: "Archives",
          ),
        ],
      ),
    );
  }
}
