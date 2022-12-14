/*
 *  This file is part of Rhythm (https://github.com/EncryptoCyphers/Rhythm).
 * 
 * Rhythm is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Rhythm is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with Rhythm.  If not, see <http://www.gnu.org/licenses/>.
 * 
 * Copyright (c) 2022-2023, EncryptoCyphers
 */
// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_player_app/pages/mini_player_and_b_nav.dart';
import 'package:music_player_app/services/switch_pages.dart';
// import 'package:music_player_app/services/data_service_and_song_query.dart';
// import 'package:music_player_app/services/screen_sizes.dart';
// import 'package:music_player_app/widgets/b_nav.dart';
import '../services/colours.dart';
// import '../widgets/circular_mini_player.dart';
import '../services/player_logic.dart';
import '../services/screen_sizes.dart';
import '../widgets/drawer_menu.dart';
//import '../widgets/bottomNavigationBar.dart';
import '../widgets/search_floating_button.dart';
// import 'mini_player.dart';

class HomePage extends StatefulWidget {
  HomePage({
    required this.nm,
  });
  String nm;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pageController = PageController(initialPage: 0);
  DateTime timeBackPressed = DateTime.now();

  // final _dataService = DataService();

  // final _musicController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrBG();
    getDeviceInfo();
    // MyClass.apiLevel = Platform.version;
    // print("API Level: " + MyClass.apiLevel);
  }

  getCurrBG() async {
    final ByteData bytes = await rootBundle.load('svg/black-background.jpg');
    defaultBG = bytes.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    getDeviceInfo();
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Scaffold(
          appBar: AppBar(
            toolbarHeight: 60,
            systemOverlayStyle: SystemUiOverlayStyle(
              // Status bar color
              statusBarColor: fgPurple,

              // Status bar brightness (optional)
              statusBarIconBrightness:
                  Brightness.dark, // For Android (dark icons)
              statusBarBrightness: Brightness.light, // For iOS (dark icons)
            ),
            backgroundColor: fgPurple,
            // actions: [
            //   Padding(
            //     padding: const EdgeInsets.only(right: 20.0),
            //     child: GestureDetector(
            //       onTap: () {
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) => const SearchPage()));
            //       },
            //       child: const Icon(
            //         Icons.search,
            //         size: 26.0,
            //       ),
            //     ),
            //   ),
            // ],
          ),
          drawer: DrawerMenu(
            pageController: pageController,
          ),
          // bottomNavigationBar:
          //     // Column(
          //     //   mainAxisSize: MainAxisSize.min,
          //     //   mainAxisAlignment: MainAxisAlignment.end,
          //     //   children: [
          //     //     const MiniPlayerWidget(),
          //     ValueListenableBuilder<double>(
          //   valueListenable: playerExpandProgress,
          //   builder:
          //       (BuildContext context, double minPlayerHeight, Widget? child) {
          //     if (minPlayerHeight <= 100) {
          //       // print('in');
          //       // return const BottomNavBar();
          //       return BNav(
          //         pageController: pageController,
          //       );
          //     } else {
          //       return SizedBox(
          //         height: 0,
          //         width: logicalWidth,
          //       );
          //     }
          //   },
          // ),
          // ],
          // ),

          backgroundColor: Colors.white,

          // Defined in switch_pages.dart
          body: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Pages(
                nm: widget.nm,
                pageController: pageController,
              ),
              const SearchButtonWithLogic(),
              MiniPlayerAndBNav(pageController: pageController),
            ],
          ),
        ),
        // MiniPlayerAndBNav(pageController: pageController),
        // AnimatedPadding(
        //   duration: const Duration(milliseconds: 200),
        //   padding: bNavPadding,
        //   child:
        // BNav(pageController: pageController),
        // ),

        // ),
        // Container(
        //   padding: EdgeInsets.fromLTRB(0, 0, logicalWidth - 90, 10),
        //   child: const CircularMiniPlayer(),
        // ),
        // Container(
        //   padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
        //   child: const MiniPlayerWidget(),
        // ),
        // const SearchButtonWithLogic(),
      ],
    );
  }
}
