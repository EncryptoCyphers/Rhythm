// SlidingClippedNavBar.colorful(
//             backgroundColor: Colors.white,
//             barItems: <BarItem>[
//               BarItem(
//                 icon: Icons.home_rounded,
//                 title: 'Home',
//                 activeColor: Colors.pink,
//                 inactiveColor: Colors.teal,
//               ),
//               BarItem(
//                 icon: FontAwesomeIcons.youtube,
//                 title: 'YT Music',
//                 activeColor: Colors.pink,
//                 inactiveColor: Colors.red,
//               ),
//               BarItem(
//                 icon: Icons.play_lesson,
//                 title: 'Local',
//                 activeColor: Colors.pink,
//                 inactiveColor: Colors.deepPurple,
//               ),
//               BarItem(
//                 icon: Icons.settings,
//                 title: 'Settings',
//                 activeColor: Colors.pink,
//                 inactiveColor: Colors.red,
//               ),
//             ],
//             selectedIndex: navIndexListener.value,
//             onButtonPressed: (index) {
//               navIndexListener.value = index;
//               widget.pageController.animateToPage(
//                 index,
//                 duration: const Duration(milliseconds: 300),
//                 curve: Curves.easeOutQuad,
//               );
//               // pageController =
//             },
//           ),