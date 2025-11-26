import 'package:flutter/material.dart';

class CreateTaskDialog extends StatefulWidget {
  final void Function(String title, String? description) onConfirm;

  const CreateTaskDialog({super.key, required this.onConfirm});

  @override
  State<CreateTaskDialog> createState() => _CreateTaskDialogState();
}

class _CreateTaskDialogState extends State<CreateTaskDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Nouvelle tâche"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              hintText: "Titre de la tâche",
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _descController,
            decoration: const InputDecoration(
              hintText: "Description (optionnel)",
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Annuler"),
        ),
        TextButton(
          onPressed: () {
            final title = _titleController.text.trim();
            final desc = _descController.text.trim().isEmpty
                ? null
                : _descController.text.trim();

            if (title.isNotEmpty) {
              widget.onConfirm(title, desc);
            }
            Navigator.pop(context);
          },
          child: const Text("Ajouter"),
        ),
      ],
    );
  }
}
