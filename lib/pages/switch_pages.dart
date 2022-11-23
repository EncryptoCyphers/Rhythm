import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player_app/pages/home.dart';
import 'package:music_player_app/pages/settings.dart';
import 'package:music_player_app/pages/songs.dart';

class Pages extends StatelessWidget {
  const Pages({super.key, required this.nm, required this.audioPlayer});
  final String nm;
  final AudioPlayer audioPlayer;

  static ValueNotifier<int> currPageIndex = ValueNotifier<int>(0);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ValueListenableBuilder<int>(
      builder: (BuildContext context, int value, Widget? child) {
        if (value == 2) {
          return Tracks(
            audioPlayer: audioPlayer,
          );
        }
        // else if ((value == 1)) {
        //   return ;
        // }
        else if ((value == 3)) {
          return const Settings();
        } else {
          return Home(
            nm: nm,
            audioPlayer: audioPlayer,
          );
        }
      },
      valueListenable: currPageIndex,
    ));
  }
}
