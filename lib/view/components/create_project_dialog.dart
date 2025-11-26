import 'package:flutter/material.dart';

class CreateProjectDialog extends StatefulWidget {
  final void Function(String name) onConfirm;

  const CreateProjectDialog({super.key, required this.onConfirm});

  @override
  State<CreateProjectDialog> createState() => _CreateProjectDialogState();
}

class _CreateProjectDialogState extends State<CreateProjectDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Créer un projet"),
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(
          hintText: "Nom du projet",
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Annuler"),
        ),
        TextButton(
          onPressed: () {
            final name = _controller.text.trim();
            if (name.isNotEmpty) {
              widget.onConfirm(name);
            }
            Navigator.pop(context);
          },
          child: const Text("Créer"),
        ),
      ],
    );
  }
}
