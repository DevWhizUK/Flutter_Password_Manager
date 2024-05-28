import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'settings.dart';

class PasswordDetailsPage extends StatefulWidget {
  final int passwordId;

  PasswordDetailsPage({required this.passwordId});

  @override
  _PasswordDetailsPageState createState() => _PasswordDetailsPageState();
}

class _PasswordDetailsPageState extends State<PasswordDetailsPage> {
  bool _isLoading = true;
  bool _obscureText = true;
  Map<String, dynamic> _passwordDetails = {};
  String _message = '';

  @override
  void initState() {
    super.initState();
    _fetchPasswordDetails();
  }

  Future<void> _fetchPasswordDetails() async {
    final response = await http.post(
      Uri.parse('http://taylorv24.sg-host.com/get_password_details.php'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({'passwordId': widget.passwordId}),
    );

    if (response.statusCode == 200) {
      setState(() {
        _passwordDetails = json.decode(response.body);
        _isLoading = false;
      });
    } else {
      setState(() {
        _message = 'Error: ${response.statusCode}';
        _isLoading = false;
      });
    }
  }

  Future<void> _deletePassword() async {
    // Implement delete password functionality
  }

  Future<void> _editPassword() async {
    // Implement edit password functionality
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Copied to clipboard'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Password Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Name: ${_passwordDetails['Name'] ?? ''}',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.copy),
                        onPressed: () => _copyToClipboard(_passwordDetails['Name'] ?? ''),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Username: ${_passwordDetails['Username'] ?? ''}',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.copy),
                        onPressed: () => _copyToClipboard(_passwordDetails['Username'] ?? ''),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Password: ${_obscureText ? '•' * (_passwordDetails['Password']?.length ?? 0) : _passwordDetails['Password'] ?? ''}',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.copy),
                        onPressed: () => _copyToClipboard(_passwordDetails['Password'] ?? ''),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'URL: ${_passwordDetails['URL'] ?? ''}',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.copy),
                        onPressed: () => _copyToClipboard(_passwordDetails['URL'] ?? ''),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: _editPassword,
                        child: Text('Edit'),
                      ),
                      ElevatedButton(
                        onPressed: _deletePassword,
                        child: Text('Delete'),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    _message,
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
    );
  }
}

