import 'package:flutter/material.dart';
import 'login.dart';
import 'settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: SettingsPage.themeNotifier,
      builder: (context, ThemeMode currentMode, child) {
        return MaterialApp(
          title: 'SecuroScanner',
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.blue,
            textTheme: TextTheme(
              headline4: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
              bodyText1: TextStyle(fontSize: 16.0),
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.blue,
            textTheme: TextTheme(
              headline4: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
              bodyText1: TextStyle(fontSize: 16.0),
            ),
          ),
          themeMode: currentMode,
          home: LoginPage(),
        );
      },
    );
  }
}
