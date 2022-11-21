// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:music_player_app/pages/switch_pages.dart';
import '../services/colours.dart';

int pageIndex = 0;
ValueNotifier<int> navIndexListener = ValueNotifier<int>(0);

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  void onItemTapped(int index) {
    pageIndex = index;
    Pages.currPageIndex.value = index;
    navIndexListener.value = index;
    // print(Pages.currPageIndex.value);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      builder: (BuildContext context, int value, Widget? child) {
        return BottomNavigationBar(
          enableFeedback: true,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_rounded),
              label: 'Home',
              backgroundColor: fgPurple,
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.public_rounded),
              label: 'Web',
              backgroundColor: Colors.pink,
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.storage_rounded),
              label: 'Local',
              backgroundColor: Colors.green,
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.settings_rounded),
              label: 'Settings',
              backgroundColor: Colors.deepOrange,
            ),
          ],
          currentIndex: pageIndex,
          selectedItemColor: Colors.yellow,
          onTap: onItemTapped,
        );
      },
      valueListenable: navIndexListener,
    );
  }
}
