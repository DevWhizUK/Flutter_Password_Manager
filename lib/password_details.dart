import 'package:flutter/material.dart';
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
                  Text('Name: ${_passwordDetails['Name']}', style: Theme.of(context).textTheme.headline6),
                  SizedBox(height: 10),
                  Text('Username: ${_passwordDetails['Username']}', style: Theme.of(context).textTheme.bodyText1),
                  SizedBox(height: 10),
                  Text('Password: ${_passwordDetails['Password']}', style: Theme.of(context).textTheme.bodyText1),
                  SizedBox(height: 10),
                  Text('URL: ${_passwordDetails['URL']}', style: Theme.of(context).textTheme.bodyText1),
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
