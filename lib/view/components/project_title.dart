import 'package:flutter/material.dart';

class ProjectTitle extends StatelessWidget {
  final String title;

  const ProjectTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title, 
      textAlign: TextAlign.center, 
      style: const TextStyle(
        fontSize: 24, 
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
