import 'package:flutter/material.dart';
import '../pages/userProfile.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        UserProfile(),
      ],
    );
  }
}
