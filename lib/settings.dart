import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'settings_provider.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var settings = Provider.of<SettingsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text('Dark Theme'),
              trailing: Switch(
                value: settings.isDarkTheme,
                onChanged: (value) {
                  settings.toggleTheme();
                },
              ),
            ),
            ListTile(
              title: Text('Font Size'),
              subtitle: Slider(
                min: 12.0,
                max: 24.0,
                value: settings.fontSize,
                onChanged: (value) {
                  settings.setFontSize(value);
                },
              ),
            ),
            ListTile(
              title: Text('Font Family'),
              subtitle: DropdownButton<String>(
                value: settings.fontFamily,
                items: <String>['Roboto', 'Arial', 'Times New Roman', 'Courier New']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  settings.setFontFamily(newValue!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
