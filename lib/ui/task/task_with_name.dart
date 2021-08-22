import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/models/task.dart';
import 'package:habit_tracker_flutter/ui/task/animated_task.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

class TaskWithName extends StatelessWidget {
  final Task task;
  final bool completed;
  final ValueChanged<bool>? onCompleted;
  const TaskWithName({
        Key? key, 
      required this.task,
      this.completed = false,
      this.onCompleted
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: AnimatedTask(
          completed: completed,
          onCompleted: onCompleted,
          iconData: task.iconName,
        ),
      ),
      SizedBox(height: 10),
      Text(
        task.name.toUpperCase(),
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 25,
            color: AppTheme.of(context).accent),
      )
    ]);
  }
}
