import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(
      //   title: const Text('Settings'),
      //   backgroundColor: Colors.purple,
      // ),
      body: Center(
        child: Text('Dummy Settings Page'),
      ),
    );
  }
}
