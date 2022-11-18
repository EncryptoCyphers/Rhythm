// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:music_player_app/pages/switch_pages.dart';
import 'package:music_player_app/services/screen_sizes.dart';
import '../services/colours.dart';
import '../widgets/drawerMenu.dart';
import 'package:just_audio/just_audio.dart';
import '../widgets/bottomNavigationBar.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import '../services/mini_player.dart';

ValueNotifier<bool> isDrawerOpen = ValueNotifier<bool>(false);

class HomePage extends StatelessWidget {
  HomePage({required this.nm, required this.audioPlayer});
  String nm;
  final AudioPlayer audioPlayer;
  DateTime timeBackPressed = DateTime.now();

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                isDrawerOpen.value = true;
              },
            ),
            backgroundColor: fgPurple,
            /*centerTitle: true,
            title: const Text("RYTHM"),*/
            actions: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: AnimSearchBar(
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: Colors.black,
                  ),
                  width: 330,
                  textController: textController,
                  onSuffixTap: () {
                    textController.clear();
                  }, // Search function is to be implemented
                  rtl: false,
                  color: Colors.white,
                  closeSearchOnSuffixTap: true,
                  helpText: 'Search artists, songs...',
                  suffixIcon: const Icon(
                    Icons.close_rounded,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          // drawer: DrawerMenu(
          //   audioPlayer: audioPlayer,
          // ),
          // bottomNavigationBar: const BottomNavBar(),
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              // Defined in switch_pages.dart
              Pages(
                audioPlayer: audioPlayer,
                nm: nm,
              ),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MiniPlayerWidget(
              audioPlayer: audioPlayer,
            ),
            ValueListenableBuilder<double>(
              valueListenable: playerExpandProgress,
              builder: (BuildContext context, double minPlayerHeight,
                  Widget? child) {
                if (minPlayerHeight <= 76) {
                  // print('in');
                  return const BottomNavBar();
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
        ValueListenableBuilder(
          valueListenable: isDrawerOpen,
          builder: (BuildContext context, bool state, Widget? child) {
            if (state) {
              return DrawerMenu(
                audioPlayer: audioPlayer,
              );
            } else {
              return const SizedBox(
                height: 0,
                width: 0,
              );
            }
          },
        )
      ],
    );
  }
}
