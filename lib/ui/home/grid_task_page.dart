import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/models/task.dart';
import 'package:habit_tracker_flutter/ui/home/grid_task.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

import 'home_flip.dart';

class GridTaskPage extends StatelessWidget {
  const GridTaskPage({Key? key, required this.tasks,required this.onFlip}) : super(key: key);
  final List<Task> tasks;
  final VoidCallback? onFlip;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.of(context).primary,
      body: SafeArea(
        child: GridTaskContent(
          tasks: tasks,
          onFlip: onFlip,
        ),
      ),
    );
  }
}

class GridTaskContent extends StatelessWidget {
  const GridTaskContent({Key? key, required this.tasks,required this.onFlip}) : super(key: key);

  final List<Task> tasks;
  final VoidCallback? onFlip;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
            child: GridTask(tasks: tasks),
          ),
        ),
         HomeFlip(
          onFlip: onFlip,
        ),
      ],
    );
  }
}
