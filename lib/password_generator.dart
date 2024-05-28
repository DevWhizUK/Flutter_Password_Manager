import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class PasswordGeneratorPage extends StatefulWidget {
  @override
  _PasswordGeneratorPageState createState() => _PasswordGeneratorPageState();
}

class _PasswordGeneratorPageState extends State<PasswordGeneratorPage> {
  final TextEditingController _passwordController = TextEditingController();
  double _length = 12;
  bool _includeUppercase = true;
  bool _includeLowercase = true;
  bool _includeNumbers = true;
  bool _includeSymbols = true;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _generatePassword() {
    final length = _length.round();
    const uppercaseLetters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const lowercaseLetters = 'abcdefghijklmnopqrstuvwxyz';
    const numbers = '0123456789';
    const symbols = '!@#\$%^&*()_-+=<>?';

    String chars = '';
    if (_includeUppercase) chars += uppercaseLetters;
    if (_includeLowercase) chars += lowercaseLetters;
    if (_includeNumbers) chars += numbers;
    if (_includeSymbols) chars += symbols;

    if (chars.isEmpty) {
      setState(() {
        _passwordController.text = '';
      });
      return;
    }

    final rand = Random();
    final password = List.generate(length, (index) => chars[rand.nextInt(chars.length)]).join();

    setState(() {
      _passwordController.text = password;
    });
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _passwordController.text));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Copied to clipboard'),
    ));
  }

  void _returnPassword() {
    Navigator.pop(context, _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Password Generator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _passwordController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Generated Password',
                suffixIcon: IconButton(
                  icon: Icon(Icons.copy),
                  onPressed: _copyToClipboard,
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text('Length: ${_length.round()}'),
                Expanded(
                  child: Slider(
                    min: 8,
                    max: 32,
                    divisions: 24,
                    value: _length,
                    onChanged: (value) {
                      setState(() {
                        _length = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            CheckboxListTile(
              title: Text('Include Uppercase Letters'),
              value: _includeUppercase,
              onChanged: (value) {
                setState(() {
                  _includeUppercase = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Include Lowercase Letters'),
              value: _includeLowercase,
              onChanged: (value) {
                setState(() {
                  _includeLowercase = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Include Numbers'),
              value: _includeNumbers,
              onChanged: (value) {
                setState(() {
                  _includeNumbers = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Include Symbols'),
              value: _includeSymbols,
              onChanged: (value) {
                setState(() {
                  _includeSymbols = value!;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _generatePassword();
                _returnPassword();
              },
              child: Text('Generate Password'),
            ),
          ],
        ),
      ),
    );
  }
}

