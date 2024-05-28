import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  static ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  double _fontSize = 16.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Theme'),
            ListTile(
              title: const Text('Light'),
              leading: Radio<ThemeMode>(
                value: ThemeMode.light,
                groupValue: SettingsPage.themeNotifier.value,
                onChanged: (ThemeMode? value) {
                  setState(() {
                    SettingsPage.themeNotifier.value = value!;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Dark'),
              leading: Radio<ThemeMode>(
                value: ThemeMode.dark,
                groupValue: SettingsPage.themeNotifier.value,
                onChanged: (ThemeMode? value) {
                  setState(() {
                    SettingsPage.themeNotifier.value = value!;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('System Default'),
              leading: Radio<ThemeMode>(
                value: ThemeMode.system,
                groupValue: SettingsPage.themeNotifier.value,
                onChanged: (ThemeMode? value) {
                  setState(() {
                    SettingsPage.themeNotifier.value = value!;
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            Text('Font Size'),
            Slider(
              value: _fontSize,
              min: 12.0,
              max: 24.0,
              divisions: 6,
              label: _fontSize.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _fontSize = value;
                  // You would normally update the text theme here
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
