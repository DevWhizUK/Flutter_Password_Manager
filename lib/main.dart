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
                headline1: TextStyle(fontSize: settings.fontSize * 2, fontFamily: settings.fontFamily),
                headline2: TextStyle(fontSize: settings.fontSize * 1.5, fontFamily: settings.fontFamily),
                headline3: TextStyle(fontSize: settings.fontSize * 1.25, fontFamily: settings.fontFamily),
                headline4: TextStyle(fontSize: settings.fontSize, fontFamily: settings.fontFamily),
                headline5: TextStyle(fontSize: settings.fontSize, fontFamily: settings.fontFamily),
                headline6: TextStyle(fontSize: settings.fontSize, fontFamily: settings.fontFamily),
                subtitle1: TextStyle(fontSize: settings.fontSize, fontFamily: settings.fontFamily),
                subtitle2: TextStyle(fontSize: settings.fontSize, fontFamily: settings.fontFamily),
                bodyText1: TextStyle(fontSize: settings.fontSize, fontFamily: settings.fontFamily),
                bodyText2: TextStyle(fontSize: settings.fontSize, fontFamily: settings.fontFamily),
                button: TextStyle(fontSize: settings.fontSize, fontFamily: settings.fontFamily),
                caption: TextStyle(fontSize: settings.fontSize, fontFamily: settings.fontFamily),
                overline: TextStyle(fontSize: settings.fontSize, fontFamily: settings.fontFamily),
              ),
            ),
            home: LoginPage(),
          );
        },
      ),
    );
  }
}
