// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_player_app/pages/web.dart';
import 'package:music_player_app/services/switch_pages.dart';
import 'package:music_player_app/services/data_service_and_song_query.dart';
import 'package:music_player_app/services/screen_sizes.dart';
import 'package:music_player_app/widgets/b_nav.dart';
import '../services/colours.dart';
import '../widgets/drawer_menu.dart';
//import '../widgets/bottomNavigationBar.dart';
import 'mini_player.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class SearchPage extends StatefulWidget {
  const SearchPage();

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final pageController = PageController(initialPage: 0);
  DateTime timeBackPressed = DateTime.now();

  final _dataService = DataService();

  final _musicController = TextEditingController();

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
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
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
                    isSearchLoading.value = true;
                    _dataService.getMusic(_musicController.text);
                  }),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const MiniPlayerWidget(),
          SizedBox(
            height: 0,
            width: logicalWidth,
          ),
        ],
      ),
      backgroundColor: Colors.white,

      // Defined in switch_pages.dart
      body: Container(),
    );
  }
}
