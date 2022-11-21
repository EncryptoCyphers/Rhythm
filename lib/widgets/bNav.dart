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
    const Color(0xffdf1b0c),
    const Color(0xff5062c2),
  ]);
  @override
  Widget build(BuildContext context) {
    return SweetNavBar(
      // paddingGradientColor: iconLinearGradiant,
      currentIndex: cIndex,
      // paddingBackgroundColor: ,
      height: 10,
      padding: EdgeInsets.zero,
      borderRadius: 0,
      items: [
        SweetNavBarItem(
          sweetActive: const Icon(Icons.home_rounded),
          sweetIcon: const Icon(Icons.home_outlined),
          sweetLabel: 'Home',
          iconColors: iconLinearGradiant,
        ),
        SweetNavBarItem(
          sweetActive: const Icon(Icons.cloud),
          sweetIcon: const Icon(Icons.cloud_queue_sharp),
          sweetLabel: 'Web',
          iconColors: iconLinearGradiant,
        ),
        SweetNavBarItem(
          sweetActive: const Icon(Icons.sd_storage_rounded),
          sweetIcon: const Icon(Icons.sd_storage_outlined),
          sweetLabel: 'Local',
          iconColors: iconLinearGradiant,
        ),
        SweetNavBarItem(
          sweetActive: const Icon(Icons.settings),
          sweetIcon: const Icon(Icons.settings_outlined),
          sweetLabel: 'Settings',
          iconColors: iconLinearGradiant,
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
