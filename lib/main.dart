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
    force: true,
    tasks: [
    Task.create(name: 'Drink Water', iconName: AppAssets.water),
    Task.create(name: 'Practice Instrument', iconName: AppAssets.guitar),
    Task.create(name: 'Read for 10 Minutes', iconName: AppAssets.book),
    Task.create(name: 'Don\'t Smoke', iconName: AppAssets.smoking),
    Task.create(name: 'Don\'t Drink Alcohol', iconName: AppAssets.beer),
    Task.create(name: 'Decrease Screen Time', iconName: AppAssets.phone),
  ]);
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
