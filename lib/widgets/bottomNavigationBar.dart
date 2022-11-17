// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:music_player_app/pages/switch_pages.dart';

int pageIndex = 0;

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  void _onItemTapped(int index) {
    setState(() {
      pageIndex = index;
      Pages.currPageIndex.value = index;
    });
    // print(Pages.currPageIndex.value);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      enableFeedback: true,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: 'Home',
          backgroundColor: Colors.deepPurple,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.public_rounded),
          label: 'Web',
          backgroundColor: Colors.green,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.storage_rounded),
          label: 'Local',
          backgroundColor: Colors.pink,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_rounded),
          label: 'Settings',
          backgroundColor: Colors.deepOrange,
        ),
      ],
      currentIndex: pageIndex,
      selectedItemColor: Colors.yellow,
      onTap: _onItemTapped,
    );
  }
}
