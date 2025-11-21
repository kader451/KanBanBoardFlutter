import 'package:flutter/material.dart';

// Ceci sera ta page principale du Kanban
class KanbanPage extends StatelessWidget {
  const KanbanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // La barre du haut avec le titre
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 223, 164, 16),
        title: const Text("Mon Kanban Board"),
        centerTitle: true, // centre le texte dans l'AppBar
      ),

      // Le corps de la page
      body: Padding(
        padding: const EdgeInsets.all(16.0), // un peu d'espace autour
        child: Center(
          // Le grand rectangle où on mettra les listes plus tard
          child: Container(
            // Occupe toute la largeur dispo
            width: double.infinity,
            // Hauteur fixe pour bien voir le rectangle (tu peux ajuster)
            height: 400,

            // Style du rectangle
            decoration: BoxDecoration(
              color: Colors.grey.shade200, // fond gris clair
              borderRadius: BorderRadius.circular(16), // bords arrondis
              border: Border.all(
                color: Colors.grey, // contour gris
                width: 2,
              ),
            ),

            // Contenu intérieur du rectangle
            child: const Center(
              child: Text(
                "Ici tu ajouteras tes listes (À faire, En cours, Terminé...)",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
