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
        return ValueListenableBuilder(
          valueListenable: SettingsPage.textStyleNotifier,
          builder: (context, TextStyle textStyle, child) {
            return MaterialApp(
              title: 'SecuroScanner',
              theme: ThemeData(
                brightness: Brightness.light,
                primarySwatch: Colors.blue,
                textTheme: TextTheme(
                  headline1: textStyle,
                  headline2: textStyle,
                  headline3: textStyle,
                  headline4: textStyle.copyWith(fontSize: 36.0, fontWeight: FontWeight.bold),
                  headline5: textStyle,
                  headline6: textStyle,
                  subtitle1: textStyle,
                  subtitle2: textStyle,
                  bodyText1: textStyle.copyWith(fontSize: textStyle.fontSize),
                  bodyText2: textStyle,
                  caption: textStyle,
                  button: textStyle,
                  overline: textStyle,
                ),
              ),
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                primarySwatch: Colors.blue,
                textTheme: TextTheme(
                  headline1: textStyle,
                  headline2: textStyle,
                  headline3: textStyle,
                  headline4: textStyle.copyWith(fontSize: 36.0, fontWeight: FontWeight.bold),
                  headline5: textStyle,
                  headline6: textStyle,
                  subtitle1: textStyle,
                  subtitle2: textStyle,
                  bodyText1: textStyle.copyWith(fontSize: textStyle.fontSize),
                  bodyText2: textStyle,
                  caption: textStyle,
                  button: textStyle,
                  overline: textStyle,
                ),
              ),
              themeMode: currentMode,
              home: LoginPage(),
            );
          },
        );
      },
    );
  }
}
