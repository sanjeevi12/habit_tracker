import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/models/task.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:habit_tracker_flutter/persistance/hive_data_store.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';
import 'package:hive/hive.dart';

import 'grid_task_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final box =  HiveDataStore();
    final box = Hive.box<Task>(HiveDataStore.tasksBoxName);
    return Scaffold(
      backgroundColor: AppTheme.of(context).primary,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 5),
          child: ValueListenableBuilder(
              valueListenable:
              //for listenable use hive_flutter import.
                  box.listenable(),
              builder: (_, Box<Task> box, __) => GridTaskPage(tasks: box.values.toList())),
        ),
      ),
    );
  }
}
