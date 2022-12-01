// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_player_app/services/switch_pages.dart';
// import 'package:music_player_app/services/data_service_and_song_query.dart';
import 'package:music_player_app/services/screen_sizes.dart';
import 'package:music_player_app/widgets/b_nav.dart';
import '../services/colours.dart';
import '../widgets/drawer_menu.dart';
//import '../widgets/bottomNavigationBar.dart';
import 'mini_player.dart';
import '../pages/search_page.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
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
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchPage()));
                },
                child: const Icon(
                  Icons.search,
                  size: 26.0,
                ),
              )),
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
