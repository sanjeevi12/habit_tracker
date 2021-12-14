import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habit_tracker_flutter/models/app_theme_settings.dart';
import 'package:habit_tracker_flutter/models/task.dart';
import 'package:habit_tracker_flutter/ui/home/grid_task.dart';
import 'package:habit_tracker_flutter/ui/sliding_panel/sliding_panel.dart';
import 'package:habit_tracker_flutter/ui/sliding_panel/sliding_panel_animator.dart';
import 'package:habit_tracker_flutter/ui/sliding_panel/theme_selection_close.dart';
import 'package:habit_tracker_flutter/ui/sliding_panel/theme_selection_list.dart';
import 'package:habit_tracker_flutter/ui/theming/animated_app_theme.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

import 'home_flip.dart';

class GridTaskPage extends StatelessWidget {
  const GridTaskPage(
      {Key? key,
      required this.tasks,
      required this.leftAnimatorKey,
      required this.rightAnimatorKey,
      required this.themeSettings,
      required this.onColorIndexSelected,
      required this.onVariantIndexSelected,
      this.onFlip})
      : super(key: key);
  final GlobalKey<SlidingPanelAnimatorState> leftAnimatorKey;
  final GlobalKey<SlidingPanelAnimatorState> rightAnimatorKey;
  final List<Task> tasks;
  final VoidCallback? onFlip;
  //! These properties are then passed as arguments to the ThemeSelectionList,
  //! so that the callbacks become available to the parent widget (the HomePage).
  final AppThemeSettings themeSettings;
  final ValueChanged<int>? onColorIndexSelected;
  final ValueChanged<int>? onVariantIndexSelected;

  void onEnterEditMode() {
    leftAnimatorKey.currentState?.slideIn();
    rightAnimatorKey.currentState?.slideIn();
  }

  void onExitEditMode() {
    leftAnimatorKey.currentState?.slideOut();
    rightAnimatorKey.currentState?.slideOut();
  }

  @override
  Widget build(BuildContext context) {
    //* Below this is used to create an Animated Theme datas, but app performs an Unique design,
    //* soo, it is good to create a app with custom dynamic theming,we can use our name to the colors Explicitly.
    // return AnimatedTheme(data: ThemeData(), child: child)
    return AnimatedAppTheme(
      duration: Duration(milliseconds: 200),
      data: themeSettings.themeData,
      //* Note that we need to use a Builder widget, otherwise calling AppTheme.of(context) will use the context
      //*of the GridTaskPage widget, which doesn't have an ancestor AppTheme.
      child: Builder(
        //* The AnnotatedRegion<SystemUiOverlayStyle> widget is used to set the appropriate system UI overlay depending on the background color.
        //* This is only needed if we're not using an AppBar (such as in this case).
        builder: (context) => AnnotatedRegion<SystemUiOverlayStyle>(
          value: AppTheme.of(context).overlayStyle,
          child: Scaffold(
            backgroundColor: AppTheme.of(context).primary,
            body: SafeArea(
              child: Stack(
                children: [
                  GridTaskContent(
                    tasks: tasks,
                    onFlip: onFlip,
                    onEnterEditMode: onEnterEditMode,
                  ),
                  Positioned(
                      bottom: 5,
                      left: 0,
                      width: SlidingPanel.leftPanelFixedWidth,
                      child: SlidingPanelAnimator(
                          key: leftAnimatorKey,
                          direction: SlideDirection.leftToRight,
                          child: ThemeSelectionClose(
                            onClose: onExitEditMode,
                          ))),
                  Positioned(
                      bottom: 5,
                      right: 0,
                      width: MediaQuery.of(context).size.width -
                          SlidingPanel.leftPanelFixedWidth,
                      child: SlidingPanelAnimator(
                          key: rightAnimatorKey,
                          direction: SlideDirection.rightToLeft,
                          child: ThemeSelectionList(
                            availableWidth: MediaQuery.of(context).size.width -
                                SlidingPanel.leftPanelFixedWidth,
                            currentThemeSettings: themeSettings,
                            onColorIndexSelected: onColorIndexSelected,
                            onVariantIndexSelected: onVariantIndexSelected,
                          )))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GridTaskContent extends StatelessWidget {
  const GridTaskContent(
      {Key? key,
      required this.tasks,
      required this.onFlip,
      required this.onEnterEditMode})
      : super(key: key);

  final List<Task> tasks;
  final VoidCallback? onFlip;
  final VoidCallback? onEnterEditMode;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: GridTask(tasks: tasks),
          ),
        ),
        HomeFlip(
          onFlip: onFlip,
          onEnterEditMode: onEnterEditMode,
        ),
      ],
    );
  }
}
