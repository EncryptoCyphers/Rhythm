import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player_app/pages/home.dart';
import 'package:music_player_app/pages/settings.dart';
import 'package:music_player_app/pages/songs.dart';
import 'package:music_player_app/pages/web.dart';

import '../widgets/b_nav.dart';

var pageController = PageController(initialPage: 0);

class Pages extends StatelessWidget {
  const Pages({super.key, required this.nm, required this.audioPlayer});
  final String nm;
  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PageView(
        onPageChanged: (index) {
          navIndexListener.value = index;
        },
        controller: pageController,
        children: [
          Home(
            nm: nm,
            audioPlayer: audioPlayer,
          ),
          const WebPage(),
          Tracks(
            audioPlayer: audioPlayer,
          ),
          const Settings()
        ],
      ),
    );
  }
}
