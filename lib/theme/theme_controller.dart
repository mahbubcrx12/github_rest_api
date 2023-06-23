import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ThemeModeType { LIGHT, DARK }

class ThemeController extends GetxController {
  Rx<ThemeModeType> themeMode = ThemeModeType.LIGHT.obs;

  void toggleTheme() {
    themeMode.value = themeMode.value == ThemeModeType.LIGHT
        ? ThemeModeType.DARK
        : ThemeModeType.LIGHT;
    Get.changeThemeMode(_getThemeMode());
  }

  ThemeMode _getThemeMode() {
    return themeMode.value == ThemeModeType.DARK
        ? ThemeMode.dark
        : ThemeMode.light;
  }
}
