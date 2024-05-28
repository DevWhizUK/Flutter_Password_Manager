import 'package:flutter/material.dart';

class PasswordGeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Password Generator'),
      ),
      body: Center(
        child: Text(
          'Password Generator Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
