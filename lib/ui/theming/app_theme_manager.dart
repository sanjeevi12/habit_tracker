import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_flutter/models/app_theme_settings.dart';
import 'package:habit_tracker_flutter/models/front_or_back_side.dart';
import 'package:habit_tracker_flutter/persistance/hive_data_store.dart';

class AppThemeManager extends StateNotifier<AppThemeSettings> {
  // AppThemeManager({required this.colorIndex,required this.variantIndex});
  AppThemeManager(
      {required this.dataStore,
      required this.side,
      required this.themeSettings})
      //! themeSettings will be a Initial values to this class.
      : super(themeSettings);

  final HiveDataStore dataStore;
  final FrontOrBackSide side;
  final AppThemeSettings themeSettings;

  void updateColorIndex(int colorIndex) {
    // state = AppThemeSettings(colorIndex:colorIndex,variantIndex: state.variantIndex);
    state = state.copyWith(colorIndex: colorIndex);
    dataStore.setAppThemeSettings(settings: state, side: side);
  }

  void updateVariantIndex(int variantIndex) {
    //! This can be used, we just add a Function for this in a AppThemeSettings so it will be Easy to access that.
    // state = AppThemeSettings(colorIndex:colorIndex,variantIndex: state.variantIndex);
    state = state.copyWith(variantIndex: variantIndex);
    dataStore.setAppThemeSettings(settings: state, side: side);
  }
}

final frontThemeManagerProvider =
    StateNotifierProvider<AppThemeManager, AppThemeSettings>(
//! These need to throw UnimplementedError() because the initial theme settings data is not known when the providers are created.
        (ref) => throw UnimplementedError());
final backThemeManagerProvider =
    StateNotifierProvider<AppThemeManager, AppThemeSettings>(
        (ref) => throw UnimplementedError());
