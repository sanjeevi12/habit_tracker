import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_flutter/constants/app_assets.dart';
import 'package:habit_tracker_flutter/constants/app_colors.dart';
import 'package:habit_tracker_flutter/models/task.dart';
import 'package:habit_tracker_flutter/persistance/hive_data_store.dart';
import 'package:habit_tracker_flutter/ui/home/home_page.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final dataSource = ref.watch(dataStoreProvider);
  final dataSource = HiveDataStore();
  await dataSource.init();
  await dataSource.createDemoTasks(
    force: false,
    frontTasks: [
      Task.create(name: 'Take Vitamins', iconName: AppAssets.vitamins),
      Task.create(name: 'Cycle to Work', iconName: AppAssets.bike),
      Task.create(name: 'Wash Your Hands', iconName: AppAssets.washHands),
      Task.create(name: 'Wear a Mask', iconName: AppAssets.mask),
      Task.create(name: 'Brush Your Teeth', iconName: AppAssets.toothbrush),
      Task.create(name: 'Floss Your Teeth', iconName: AppAssets.dentalFloss),
    ],
    backTasks: [
      Task.create(name: 'Eat a Healthy Meal', iconName: AppAssets.carrot),
      Task.create(name: 'Walk the Dog', iconName: AppAssets.dog),
      Task.create(name: 'Do Some Coding', iconName: AppAssets.html),
      Task.create(name: 'Meditate', iconName: AppAssets.meditation),
      Task.create(name: 'Do 10 Pushups', iconName: AppAssets.pushups),
      Task.create(name: 'Sleep 8 Hours', iconName: AppAssets.rest),
    ],);
  //   tasks: [
  //   Task.create(name: 'Drink Water', iconName: AppAssets.water),
  //   Task.create(name: 'Practice Instrument', iconName: AppAssets.guitar),
  //   Task.create(name: 'Read for 10 Minutes', iconName: AppAssets.book),
  //   Task.create(name: 'Don\'t Smoke', iconName: AppAssets.smoking),
  //   Task.create(name: 'Don\'t Drink Alcohol', iconName: AppAssets.beer),
  //   Task.create(name: 'Decrease Screen Time', iconName: AppAssets.phone),
  // ]);
  await AppAssets.preloadSVGs();
  runApp(ProviderScope(
    overrides: [
      //* it is used to overRide a Dependency Injection to be took Place and places the dataStoreprovider Globally.
      dataStoreProvider.overrideWithValue(dataSource)
    ],
    child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Helvetica Neue',
      ),
      home: AppTheme(
        data: AppThemeData.defaultWithSwatch(AppColors.red),
        child: HomePage(),
      ),
    );
  }
}
