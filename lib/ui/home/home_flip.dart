import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

class HomeFlip extends StatelessWidget {
  const HomeFlip({Key? key, this.onFlip}) : super(key: key);
  final VoidCallback? onFlip;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onFlip,
          icon: Icon(
            Icons.flip,
            color: AppTheme.of(context).settingsLabel,
          ),
        ),
      ],
    );
  }
}
