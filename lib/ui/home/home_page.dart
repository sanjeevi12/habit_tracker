import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_flutter/models/task.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:habit_tracker_flutter/persistance/hive_data_store.dart';
import 'package:hive/hive.dart';

import 'grid_task_page.dart';

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataStore = ref.watch(dataStoreProvider);
    // final box = Hive.box<Task>(HiveDataStore.tasksBoxName);
    return
        //  Scaffold(
        //   backgroundColor: AppTheme.of(context).primary,
        ValueListenableBuilder(
            valueListenable: dataStore.frontTasksListenable(),
            builder: (_, Box<Task> box, __) =>
                GridTaskPage(tasks: box.values.toList()));
  }
}
