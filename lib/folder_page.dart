import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'password_details.dart';
import 'settings.dart';

class FolderPage extends StatefulWidget {
  final int folderId;
  final String folderName;

  FolderPage({required this.folderId, required this.folderName});

  @override
  _FolderPageState createState() => _FolderPageState();
}

class _FolderPageState extends State<FolderPage> {
  List<dynamic> _passwords = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPasswords();
  }

  Future<void> _fetchPasswords() async {
    final response = await http.post(
      Uri.parse('http://taylorv24.sg-host.com/get_passwords_by_folder.php'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({'folderId': widget.folderId}),
    );

    if (response.statusCode == 200) {
      setState(() {
        _passwords = json.decode(response.body);
        _isLoading = false;
      });
    } else {
      setState(() {
        _passwords = [];
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.folderName),
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
          : _buildPasswordList(),
    );
  }

  Widget _buildPasswordList() {
    if (_passwords.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text('No passwords available in this folder.'),
      );
    }
    return ListView.builder(
      itemCount: _passwords.length,
      itemBuilder: (context, index) {
        final password = _passwords[index];
        return ListTile(
          title: Text(password['Name']),
          subtitle: Text(password['Username']),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PasswordDetailsPage(passwordId: password['PasswordID'])),
            );
          },
        );
      },
    );
  }
}
