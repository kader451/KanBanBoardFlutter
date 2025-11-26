import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/projet_view_model.dart';
import '../models/projets.dart';
import 'components/project_title.dart';
import 'components/status_column.dart';
import 'components/create_project_dialog.dart';


class KanbanPage extends StatelessWidget {
  const KanbanPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    // On récupère le ViewModel avec le Provider
    final vm = context.watch<ProjectsViewModel>();

    final Project? project = vm.currentProject;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 223, 164, 16),
        title: const Text("Kanban"),
        actions: [
          // Bouton + pour créer un projet
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => CreateProjectDialog(
                  onConfirm: (name) => vm.createOrSetCurrentProject(name),
                ),
              );
            },
          ),
        ],
      ),

      body: project == null
          ? const Center(
              child: Text(
                "Clique sur + pour créer un projet.",
                textAlign: TextAlign.center,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ProjectTitle(title: project.name),

                  const SizedBox(height: 16),

                  Expanded(child: _buildResponsiveBoard(context)),
                ],
              ),
            ),
    );
  }

  // ||||||||||||||||||||||| RESPONSIVE |||||||||||||||||||-

  Widget _buildResponsiveBoard(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final bool isMobile = width < 600;
    final bool isTablet = width >= 600 && width < 1000;

    if (isMobile) {
      return _buildMobileLayout();
    } else if (isTablet) {
      return _buildTabletLayout();
    } else {
      return _buildDesktopLayout();
    }
  }

  /// Un scroll pour 4 colonnes sur mobile
  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: const [
          SizedBox(
            width: 300,
            child: StatusColumn(title: "À faire", statusKey: "todo"),
          ),
          SizedBox(width: 12),
          SizedBox(
            width: 300,
            child: StatusColumn(title: "En cours", statusKey: "doing"),
          ),
          SizedBox(width: 12),
          SizedBox(
            width: 300,
            child: StatusColumn(title: "À tester", statusKey: "testing"),
          ),
          SizedBox(width: 12),
          SizedBox(
            width: 300,
            child: StatusColumn(title: "Terminé", statusKey: "done"),
          ),
        ],
      ),
    );
  }

  /// 2 colonnes sur 2 lignes pour la tablette
  Widget _buildTabletLayout() {
    return Column(
      children: const [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: StatusColumn(title: "À faire", statusKey: "todo"),
              ),
              SizedBox(width: 8),
              Expanded(
                child: StatusColumn(title: "En cours", statusKey: "doing"),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: StatusColumn(title: "À tester", statusKey: "testing"),
              ),
              SizedBox(width: 8),
              Expanded(
                child: StatusColumn(title: "Terminé", statusKey: "done"),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Mes 4 colonnes A faire jusqu'a terminé
  Widget _buildDesktopLayout() {
    return Row(
      children: const [
        Expanded(
          child: StatusColumn(title: "À faire", statusKey: "todo"),
        ),
        SizedBox(width: 8),
        Expanded(
          child: StatusColumn(title: "En cours", statusKey: "doing"),
        ),
        SizedBox(width: 8),
        Expanded(
          child: StatusColumn(title: "À tester", statusKey: "testing"),
        ),
        SizedBox(width: 8),
        Expanded(
          child: StatusColumn(title: "Terminé", statusKey: "done"),
        ),
      ],
    );
  }
}
