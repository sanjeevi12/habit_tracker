import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/models/task_preset.dart';
import 'package:habit_tracker_flutter/ui/home/grid_task.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

class GridTaskPage extends StatelessWidget {
  const GridTaskPage({Key? key, required this.tasks}) : super(key: key);
  final List<TaskPreset> tasks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.of(context).primary,
      body: SafeArea(
        child: GridTaskContent(
          tasks: tasks,
        ),
      ),
    );
  }
}

class GridTaskContent extends StatelessWidget {
  const GridTaskContent({Key? key, required this.tasks}) : super(key: key);

  final List<TaskPreset> tasks;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 14),
      child: GridTask(tasks: tasks),
    );
  }
}
