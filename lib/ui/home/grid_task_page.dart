import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/models/app_theme_settings.dart';
import 'package:habit_tracker_flutter/models/task.dart';
import 'package:habit_tracker_flutter/ui/home/grid_task.dart';
import 'package:habit_tracker_flutter/ui/sliding_panel/sliding_panel.dart';
import 'package:habit_tracker_flutter/ui/sliding_panel/sliding_panel_animator.dart';
import 'package:habit_tracker_flutter/ui/sliding_panel/theme_selection_close.dart';
import 'package:habit_tracker_flutter/ui/sliding_panel/theme_selection_list.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

import 'home_flip.dart';

class GridTaskPage extends StatelessWidget {
  const GridTaskPage({Key? key, required this.tasks, required this.onFlip})
      : super(key: key);
  final List<Task> tasks;
  final VoidCallback? onFlip;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.of(context).primary,
      body: SafeArea(
        child: Stack(
          children: [
            GridTaskContent(
              tasks: tasks,
              onFlip: onFlip,
            ),
            Positioned(
                bottom: 5,
                left: 0,
                width: SlidingPanel.leftPanelFixedWidth,
                child: SlidingPanelAnimator(
                    direction: SlideDirection.leftToRight,
                    child: ThemeSelectionClose())),
            Positioned(
                bottom: 5,
                right: 0,
                width: MediaQuery.of(context).size.width -
                    SlidingPanel.leftPanelFixedWidth,
                child: SlidingPanelAnimator(
                    direction: SlideDirection.rightToLeft,
                    child: ThemeSelectionList(
                      availableWidth: MediaQuery.of(context).size.width -
                          SlidingPanel.leftPanelFixedWidth,
                      currentThemeSettings:
                          AppThemeSettings(colorIndex: 0, variantIndex: 0),
                    )))
          ],
        ),
      ),
    );
  }
}

class GridTaskContent extends StatelessWidget {
  const GridTaskContent({Key? key, required this.tasks, required this.onFlip})
      : super(key: key);

  final List<Task> tasks;
  final VoidCallback? onFlip;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
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
