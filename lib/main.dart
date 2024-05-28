import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login.dart';
import 'settings_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SettingsProvider(),
      child: Consumer<SettingsProvider>(
        builder: (context, settings, child) {
          return MaterialApp(
            title: 'SecuroScanner',
            theme: ThemeData(
              brightness: settings.isDarkTheme ? Brightness.dark : Brightness.light,
              primaryColor: Colors.blue,
              hintColor: Colors.blueAccent,
              textTheme: TextTheme(
                bodyText2: TextStyle(
                  fontSize: settings.fontSize,
                  fontFamily: settings.fontFamily,
                ),
              ),
            ),
            home: LoginPage(),
          );
        },
      ),
    );
  }
}


