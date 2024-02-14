import 'package:flutter/material.dart';
import 'package:logandprice/Aut/loginscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkModeEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadNightModeState();
  }

  _loadNightModeState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkModeEnabled = prefs.getBool('isDarkModeEnabled') ?? false;
    });
  }

  _saveNightModeState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkModeEnabled', isDarkModeEnabled);
  }

  _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Logout Confirmation",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromARGB(255, 36, 130, 111),
              fontSize: 20,
            ),
          ),
          content: Text(
            "Are you sure you want to log out?",
            textAlign: TextAlign.left,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text("No",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color.fromARGB(255, 36, 130, 111),
                    fontSize: 15,
                  )),
            ),
            TextButton(
              onPressed: () {
                // Perform logout action
                // Navigate to login screen or handle logout logic
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const loginn(),
                  ),
                );
              },
              child: Text(
                "Yes",
                style: TextStyle(
                  color: Color.fromARGB(255, 36, 130, 111),
                  fontSize: 15,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(-23, 36, 130, 111),
          title: const Text('Settings'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              ListTile(
                title: Text('Dark Mode'),
                trailing: Switch(
                  value: isDarkModeEnabled,
                  onChanged: (value) {
                    setState(() {
                      isDarkModeEnabled = value;
                      _saveNightModeState();
                    });
                  },
                ),
              ),
              ListTile(
                title: Text('Notifications'),
                trailing: Switch(
                  value: true, // Set the actual value based on user preference
                  onChanged: (value) {
                    // Handle notification toggle
                  },
                ),
              ),
              Divider(),
              Text(
                'Account Settings',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              ListTile(
                title: Text('Change Password'),
                onTap: () {
                  // Handle change password action
                },
              ),
              ListTile(
                title: Text('Logout'),
                onTap: () {
                  _showLogoutConfirmationDialog();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
