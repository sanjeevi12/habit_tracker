import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_flutter/models/task.dart';
import 'package:habit_tracker_flutter/persistance/hive_data_store.dart';
import 'package:habit_tracker_flutter/ui/sliding_panel/sliding_panel_animator.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme_manager.dart';
// import 'package:habit_tracker_flutter/ui/home/page_flip_builder.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:hive/hive.dart';
import 'package:page_flip_builder/page_flip_builder.dart';

import 'grid_task_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageFlipKey = GlobalKey<PageFlipBuilderState>();
  final frontLeftAnimatedkey = GlobalKey<SlidingPanelAnimatorState>();
  final frontRightAnimatedkey = GlobalKey<SlidingPanelAnimatorState>();
  final backLeftAnimatedkey = GlobalKey<SlidingPanelAnimatorState>();
  final backRightAnimatedkey = GlobalKey<SlidingPanelAnimatorState>();

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, ref, __) {
      final dataStore = ref.watch(dataStoreProvider);
      return PageFlipBuilder(
        key: _pageFlipKey,
        frontBuilder: (_) => ValueListenableBuilder(
            valueListenable: dataStore.frontTasksListenable(),
            builder: (_, Box<Task> box, __) => GridTaskPage(
                  leftAnimatorKey: frontLeftAnimatedkey,
                  rightAnimatorKey: frontRightAnimatedkey,
                  key: ValueKey(0),
                  tasks: box.values.toList(),
                  onFlip: () {
                    _pageFlipKey.currentState?.flip();
                  },
                  themeSettings: ref.watch(frontThemeManagerProvider),
                  onColorIndexSelected: (colorIndex) => ref
                      .read(frontThemeManagerProvider.notifier)
                      .updateColorIndex(colorIndex),
                  onVariantIndexSelected: (variantIndex) => ref
                      .read(frontThemeManagerProvider.notifier)
                      .updateVariantIndex(variantIndex),
                )),
        backBuilder: (_) => ValueListenableBuilder(
            valueListenable: dataStore.backTasksListenable(),
            builder: (_, Box<Task> box, __) => GridTaskPage(
                  leftAnimatorKey: backLeftAnimatedkey,
                  rightAnimatorKey: backRightAnimatedkey,
                  key: ValueKey(1),
                  tasks: box.values.toList(),
                  onFlip: () {
                    _pageFlipKey.currentState?.flip();
                  },
                  //* AppThemeManager != AppThemeSettings
                  //* In Implementing a StateNotifier you have write a specific Type to that stateNotifier to access the provider of the state 
                 //* We can watch the Provider state and rebuild the widget if the state changes.
                  themeSettings: ref.watch(backThemeManagerProvider),
                  onColorIndexSelected: (colorIndex) => ref

                  //* ref to access the AppThemeManager.
                  //* this will give a access to the themeProvider 
                  //* Need to use notifier to access the state of that provider.
                  //* use ref.watch() from the build () method to rebuild your widget when the provider state changes 
                  //* use ref.read() when your in inside a callback and you wnat to call a method of the provider.
                      .read(backThemeManagerProvider.notifier)
                      .updateColorIndex(colorIndex),
                  onVariantIndexSelected: (variantIndex) => ref
                      .read(backThemeManagerProvider.notifier)
                      .updateVariantIndex(variantIndex),
                )),
      );
    });
  }
}
