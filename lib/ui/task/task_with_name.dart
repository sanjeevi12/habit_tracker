import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/constants/text_styles.dart';
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
      SizedBox(height: 8),
      SizedBox(
        height: 39,
              child: Text(
          task.name.toUpperCase(),
          // maxLines: 2,
          textAlign: TextAlign.center,
          style:TextStyles.taskName.copyWith(
              color: AppTheme.of(context).accent,
            ),
        ),
      )
    ]);
  }
}
