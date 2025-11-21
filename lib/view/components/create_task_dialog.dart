import 'package:flutter/material.dart';

class CreateTaskDialog extends StatelessWidget {
  final Function(String title, String? description) onConfirm;

  const CreateTaskDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descController = TextEditingController();

    return AlertDialog(
      title: const Text("Nouvelle étiquette"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: "Titre"),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: descController,
            maxLines: 3,
            decoration: const InputDecoration(labelText: "Description"),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Annuler"),
        ),
        ElevatedButton(
          onPressed: () {
            final title = titleController.text.trim();
            final desc = descController.text.trim();

            if (title.isNotEmpty) {
              onConfirm(title, desc.isEmpty ? null : desc);
              Navigator.pop(context);
            }
          },
          child: const Text("Créer"),
        ),
      ],
    );
  }
}
