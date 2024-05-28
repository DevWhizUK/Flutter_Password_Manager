import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier {
  bool _isDarkTheme = true;
  double _fontSize = 16.0;
  String _fontFamily = 'Roboto';

  bool get isDarkTheme => _isDarkTheme;
  double get fontSize => _fontSize;
  String get fontFamily => _fontFamily;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  void setFontSize(double size) {
    _fontSize = size;
    notifyListeners();
  }

  void setFontFamily(String family) {
    _fontFamily = family;
    notifyListeners();
  }
}
