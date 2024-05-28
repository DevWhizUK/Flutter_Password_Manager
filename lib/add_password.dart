import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'settings.dart';
import 'password_generator.dart';

class AddPasswordPage extends StatefulWidget {
  final int userId;

  AddPasswordPage({required this.userId});

  @override
  _AddPasswordPageState createState() => _AddPasswordPageState();
}

class _AddPasswordPageState extends State<AddPasswordPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _folderNameController = TextEditingController();
  bool _isLoading = false;
  bool _obscureText = true;
  String _message = '';
  String _selectedOption = 'Password';
  int? _selectedFolder;
  List<dynamic> _folders = [];

  @override
  void initState() {
    super.initState();
    _fetchFolders();
  }

  Future<void> _fetchFolders() async {
    final response = await http.post(
      Uri.parse('http://taylorv24.sg-host.com/get_folders.php'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({'userId': widget.userId}),
    );

    if (response.statusCode == 200) {
      setState(() {
        _folders = json.decode(response.body);
      });
    } else {
      setState(() {
        _folders = [];
      });
    }
  }

  Future<void> _addPassword() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.post(
      Uri.parse('http://taylorv24.sg-host.com/add_password.php'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userId': widget.userId,
        'name': _nameController.text,
        'username': _usernameController.text,
        'password': _passwordController.text,
        'url': _urlController.text,
        'folderId': _selectedFolder
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        _message = data['message'];
      });
      if (data['message'] == 'Password saved successfully') {
        Navigator.pop(context, true); // Return true to indicate success
      }
    } else {
      setState(() {
        _message = 'Error: ${response.statusCode}';
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _addFolder() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.post(
      Uri.parse('http://taylorv24.sg-host.com/add_folder.php'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userId': widget.userId,
        'folderName': _folderNameController.text,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        _message = data['message'];
      });
      if (data['message'] == 'Folder added successfully') {
        _fetchFolders(); // Refresh folders list after adding a new folder
      }
    } else {
      setState(() {
        _message = 'Error: ${response.statusCode}';
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _navigateToPasswordGenerator() async {
    final generatedPassword = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PasswordGeneratorPage()),
    );

    if (generatedPassword != null && generatedPassword is String) {
      _passwordController.text = generatedPassword;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add ${_selectedOption}'),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            DropdownButton<String>(
              value: _selectedOption,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedOption = newValue!;
                });
              },
              items: <String>['Password', 'Folder']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            if (_selectedOption == 'Password') ...[
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.label),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
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
                        icon: Icon(Icons.refresh),
                        onPressed: _navigateToPasswordGenerator,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _urlController,
                decoration: InputDecoration(
                  labelText: 'URL',
                  prefixIcon: Icon(Icons.link),
                ),
              ),
              SizedBox(height: 20),
              DropdownButton<int>(
                value: _selectedFolder,
                hint: Text('Select Folder'),
                onChanged: (int? newValue) {
                  setState(() {
                    _selectedFolder = newValue;
                  });
                },
                items: _folders.map<DropdownMenuItem<int>>((dynamic folder) {
                  return DropdownMenuItem<int>(
                    value: folder['FolderID'],
                    child: Text(folder['FolderName']),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _addPassword,
                      child: Text('Save Password'),
                    ),
            ] else if (_selectedOption == 'Folder') ...[
              TextField(
                controller: _folderNameController,
                decoration: InputDecoration(
                  labelText: 'Folder Name',
                  prefixIcon: Icon(Icons.folder),
                ),
              ),
              SizedBox(height: 20),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _addFolder,
                      child: Text('Save Folder'),
                    ),
            ],
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
