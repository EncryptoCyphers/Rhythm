import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music_player_app/services/colours.dart';
import 'package:music_player_app/services/screen_sizes.dart';
// import 'package:sweet_nav_bar/sweet_nav_bar.dart';
// import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
// import '../services/navbar/sliding_clipped_nav_bar.dart';
import '../services/navbar/src/widget/nav_bar_button.dart';
// import 'package:sweet_nav_bar/sweet_nav_bar.dart';
// import '../services/switch_pages.dart';
// import 'package:dot_navigation_bar/dot_navigation_bar.dart';

ValueNotifier<int> navIndexListener = ValueNotifier<int>(0);
var bNavPadding = const EdgeInsets.fromLTRB(0, 0, 45, 0);

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
        return Container(
          // decoration: const BoxDecoration(
          //   color: Color(0xFFffffff),
          //   boxShadow: [
          //     BoxShadow(
          //       color: Colors.grey,
          //       blurRadius: 15.0, // soften the shadow
          //       spreadRadius: 5.0, //extend the shadow
          //       offset: Offset(
          //         5.0, // Move to right 5  horizontally
          //         5.0, // Move to bottom 5 Vertically
          //       ),
          //     )
          //   ],
          // ),
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          // color: Colors.transparent,
          // color: Colors.red,
          width: logicalWidth - 90,
          height: 70,
          // decoration: BoxDecoration(
          //   color: Colors.white,
          //   borderRadius: BorderRadius.circular(40),
          //   boxShadow: [
          //     BoxShadow(
          //       color: Color.fromARGB(255, 67, 64, 64).withOpacity(0.5),
          //       blurRadius: 8,
          //       spreadRadius: 6,
          //       offset: const Offset(0, 0),
          //     ),
          //   ],
          // ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 67, 64, 64).withOpacity(0.4),
                  blurRadius: 8,
                  spreadRadius: 3,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(40)),
              // child: Container(
              // color: Colors.red,
              // padding: const EdgeInsets.only(bottom: 10),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: ((context, index) {
                  return NavBarButton(
                    icon: (index == 0)
                        ? (FontAwesomeIcons.youtube)
                        : ((index == 1) ? (Icons.play_lesson) : (Icons.person)),
                    size: 30,
                    title: (index == 0)
                        ? ("YT Music")
                        : ((index == 1) ? ("Local") : ("Profile")),
                    activeColor: fgPurple,
                    inactiveColor: fgPurple,
                    index: index,
                    isSelected: navIndexListener.value == index ? true : false,
                    onTap: (index) {
                      navIndexListener.value = index;
                      widget.pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOutQuad,
                      );
                      // pageController =
                    },
                    slidingCardColor: Colors.white,
                    itemCount: 3,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                  );
                }),
              ),
            ),
          ),
        );
      },
    );
  }
}
