import 'package:flutter/material.dart';

class CreateProjectDialog extends StatelessWidget {
  final Function(String name) onConfirm;

  const CreateProjectDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return AlertDialog(
      title: const Text("Créer un projet"),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(hintText: "Nom du projet"),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Annuler"),
        ),
        ElevatedButton(
          onPressed: () {
            final name = controller.text.trim();
            if (name.isNotEmpty) {
              onConfirm(name);
              Navigator.pop(context);
            }
          },
          child: const Text("Créer"),
        ),
      ],
    );
  }
}
