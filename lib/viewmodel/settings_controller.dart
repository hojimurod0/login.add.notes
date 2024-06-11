
import 'package:flutter/material.dart';

import '../data/local_data.dart';
import '../models/settings.dart';

class SettingsController extends ChangeNotifier {
  final LocalData? themeModeData;
  final LocalData? sizeTextData;
  final appTheme = AppTheme(themeMode: ThemeMode.system);
  final sizeText = SizeText(size: 14, color: Colors.grey);

  SettingsController({this.themeModeData, this.sizeTextData});

  Future<void> loadTheme() async {
    if (themeModeData != null) {
      bool isDark = await themeModeData!.getThemeMode();
      appTheme.themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
      notifyListeners();
    }
  }

  void toggleTheme(bool isDark) {
    if (themeModeData != null) {
      appTheme.themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
      themeModeData!.saveThemeMode(isDark);
      notifyListeners();
    }
  }

  Future<void> loadSizeText() async {
    if (sizeTextData != null) {
      double size = await sizeTextData!.getSizeText();
      sizeText.size = size;
      notifyListeners();
    }
  }

  void setSizeText(double size) {
    if (sizeTextData != null) {
      sizeText.size = size;
      sizeTextData!.saveSizeText(size);
      notifyListeners();
    }
  }

  Future<void> loadColorText() async {
    if (sizeTextData != null) {
      int color = int.parse("0xff${await sizeTextData!.getColorText()}");
      sizeText.color = Color(color);
      notifyListeners();
    }
  }

  void setColor(Color color) {
    if (sizeTextData != null) {
      sizeText.color = color;
      sizeTextData!.saveColorText(color.value.toRadixString(16));
      notifyListeners();
    }
  }
}
