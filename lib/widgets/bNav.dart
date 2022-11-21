import 'package:flutter/material.dart';
import 'package:sweet_nav_bar/sweet_nav_bar.dart';

import '../pages/switch_pages.dart';

class BNav extends StatefulWidget {
  const BNav({super.key});

  @override
  State<BNav> createState() => _BNavState();
}

class _BNavState extends State<BNav> {
  int cIndex = 0;
  void onItemTapped(int index) {
    cIndex = index;
    Pages.currPageIndex.value = index;
    // print(Pages.currPageIndex.value);
  }

  final iconLinearGradiant = List<Color>.from([
    const Color.fromARGB(255, 251, 2, 197),
    const Color.fromARGB(255, 72, 3, 80)
  ]);
  @override
  Widget build(BuildContext context) {
    return SweetNavBar(
      // paddingGradientColor: iconLinearGradiant,
      currentIndex: cIndex,
      paddingBackgroundColor: Colors.deepPurple.shade400,
      items: [
        SweetNavBarItem(
          sweetActive: const Icon(Icons.home_rounded),
          sweetIcon: const Icon(Icons.home_outlined),
          sweetLabel: 'Home',
          iconColors: iconLinearGradiant,
        ),
        SweetNavBarItem(
          sweetActive: const Icon(Icons.public_rounded),
          sweetIcon: const Icon(Icons.public_outlined),
          sweetLabel: 'Web',
        ),
        SweetNavBarItem(
          sweetActive: const Icon(Icons.sd_storage_rounded),
          sweetIcon: const Icon(Icons.sd_storage_outlined),
          sweetLabel: 'Local',
        ),
        SweetNavBarItem(
          sweetActive: const Icon(Icons.settings),
          sweetIcon: const Icon(Icons.settings_outlined),
          sweetLabel: 'Settings',
        ),
      ],
      onTap: (index) {
        setState(() {
          cIndex = index;
          onItemTapped(index);
        });
      },
    );
  }
}
