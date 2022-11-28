import 'package:flutter/material.dart';
// import 'package:sweet_nav_bar/sweet_nav_bar.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
// import '../services/switch_pages.dart';

ValueNotifier<int> navIndexListener = ValueNotifier<int>(0);

class BNav extends StatefulWidget {
  const BNav({super.key, required this.pageController});
  final PageController pageController;

  @override
  State<BNav> createState() => _BNavState();
}

class _BNavState extends State<BNav> {
  final iconLinearGradiant = List<Color>.from([
    const Color(0xffdf1b0c),
    const Color(0xff5062c2),
  ]);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: navIndexListener,
      builder: (BuildContext context, int value, Widget? child) {
        return SlidingClippedNavBar.colorful(
          backgroundColor: Colors.white,
          barItems: <BarItem>[
            BarItem(
              icon: Icons.home_rounded,
              title: 'Home',
              activeColor: Colors.pink,
              inactiveColor: Colors.teal,
            ),
            BarItem(
              icon: Icons.youtube_searched_for,
              title: 'YT Music',
              activeColor: Colors.pink,
              inactiveColor: Colors.deepOrange,
            ),
            BarItem(
              icon: Icons.play_lesson,
              title: 'Local',
              activeColor: Colors.pink,
              inactiveColor: Colors.deepPurple,
            ),
            BarItem(
              icon: Icons.settings,
              title: 'Settings',
              activeColor: Colors.pink,
              inactiveColor: Colors.red,
            ),
          ],
          selectedIndex: navIndexListener.value,
          onButtonPressed: (index) {
            navIndexListener.value = index;
            widget.pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutQuad,
            );
            // pageController =
          },
        );
        // return SweetNavBar(
        //   // paddingGradientColor: iconLinearGradiant,
        //   currentIndex: navIndexListener.value,
        //   // paddingBackgroundColor: ,
        //   height: 10,
        //   padding: EdgeInsets.zero,
        //   borderRadius: 0,
        //   items: [
        //     SweetNavBarItem(
        //       sweetActive: const Icon(Icons.home_rounded),
        //       sweetIcon: const Icon(Icons.home_outlined),
        //       sweetLabel: 'Home',
        //       iconColors: iconLinearGradiant,
        //     ),
        //     SweetNavBarItem(
        //       sweetActive: const Icon(Icons.cloud),
        //       sweetIcon: const Icon(Icons.cloud_queue_sharp),
        //       sweetLabel: 'Web',
        //       iconColors: iconLinearGradiant,
        //     ),
        //     SweetNavBarItem(
        //       sweetActive: const Icon(Icons.sd_storage_rounded),
        //       sweetIcon: const Icon(Icons.sd_storage_outlined),
        //       sweetLabel: 'Local',
        //       iconColors: iconLinearGradiant,
        //     ),
        //     SweetNavBarItem(
        //       sweetActive: const Icon(Icons.settings),
        //       sweetIcon: const Icon(Icons.settings_outlined),
        //       sweetLabel: 'Settings',
        //       iconColors: iconLinearGradiant,
        //     ),
        //   ],
        //   onTap: (index) {
        //     navIndexListener.value = index;
        //     Pages.currPageIndex.value = index;
        //   },
        // );
      },
    );
  }
}
