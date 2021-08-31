import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_flutter/models/task.dart';
// import 'package:habit_tracker_flutter/ui/home/page_flip_builder.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:habit_tracker_flutter/persistance/hive_data_store.dart';
import 'package:hive/hive.dart';
import 'package:page_flip_builder/page_flip_builder.dart';

import 'grid_task_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageFlipKey = GlobalKey<PageFlipBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, ref, __) {
      final dataStore = ref.watch(dataStoreProvider);
      return PageFlipBuilder(
        key: _pageFlipKey,
        frontBuilder: (_) => ValueListenableBuilder(
            valueListenable: dataStore.frontTasksListenable(),
            builder: (_, Box<Task> box, __) => GridTaskPage(
                key: ValueKey(0),
                tasks: box.values.toList(),
                onFlip: () {
                  _pageFlipKey.currentState?.flip();
                })),
        backBuilder: (_) => ValueListenableBuilder(
            valueListenable: dataStore.backTasksListenable(),
            builder: (_, Box<Task> box, __) => GridTaskPage(
                key: ValueKey(1),
                tasks: box.values.toList(),
                onFlip: () {
                  _pageFlipKey.currentState?.flip();
                })),
      );
    });
  }
}
