// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_player_app/services/switch_pages.dart';
import 'package:music_player_app/services/data_service.dart';
import 'package:music_player_app/services/screen_sizes.dart';
import 'package:music_player_app/widgets/b_nav.dart';
import '../services/colours.dart';
import '../widgets/drawer_menu.dart';
//import '../widgets/bottomNavigationBar.dart';
import 'mini_player.dart';
import 'package:searchbar_animation/searchbar_animation.dart';
import '../pages/home.dart';
import '../pages/web.dart';
import '../pages/songs.dart';
import '../pages/settings.dart';

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

  final _dataService = DataService();

  final _musicController = TextEditingController();

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: const Icon(Icons.menu),
        //   onPressed: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => DrawerMenu(
        //           audioPlayer: audioPlayer,
        //         ),
        //       ),
        //     );
        //   },
        // ),
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: fgPurple,

          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        backgroundColor: fgPurple,
        /*centerTitle: true,
            title: const Text("RYTHM"),*/
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            // child: AnimSearchBar(
            //   prefixIcon: const Icon(
            //     Icons.search_rounded,
            //     color: Colors.black,
            //   ),
            //   width: 330,
            //   textController: textController,
            //   onSuffixTap: () {
            //     textController.clear();
            //   }, // Search function is to be implemented
            //   rtl: false,
            //   color: Colors.white,
            //   closeSearchOnSuffixTap: true,
            //   helpText: 'Search artists, songs...',
            //   suffixIcon: const Icon(
            //     Icons.close_rounded,
            //     color: Colors.black,
            //   ),
            // ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: SearchBarAnimation(
                  textEditingController: _musicController,
                  isOriginalAnimation: true,
                  durationInMilliSeconds: 300,
                  trailingWidget: const Icon(Icons.search),
                  secondaryButtonWidget: const Icon(Icons.close),
                  buttonWidget: const Icon(Icons.search),
                  isSearchBoxOnRightSide: true,
                  hintText: "Search Songs, Artists...",
                  //hintTextColour: Colors.deepPurple,
                  enableKeyboardFocus: true,
                  onFieldSubmitted: (String value) {
                    _dataService.getMusic(_musicController.text);
                  }),
            ),
          ),
        ],
      ),
      drawer: DrawerMenu(
        pageController: pageController,
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const MiniPlayerWidget(),
          ValueListenableBuilder<double>(
            valueListenable: playerExpandProgress,
            builder:
                (BuildContext context, double minPlayerHeight, Widget? child) {
              if (minPlayerHeight <= 100) {
                // print('in');
                // return const BottomNavBar();
                return BNav(
                  pageController: pageController,
                );
              } else {
                return SizedBox(
                  height: 0,
                  width: logicalWidth,
                );
              }
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,

      // Defined in switch_pages.dart
      body: Pages(
        nm: widget.nm,
        pageController: pageController,
      ),
    );
  }
}
