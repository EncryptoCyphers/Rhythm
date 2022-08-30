import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:ui';

import 'package:on_audio_query/on_audio_query.dart';

final _audioPlayer = AudioPlayer();
playSong(String? uri) {
  try {
    _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
    _audioPlayer.play();
  } on Exception {
    log("Error Parsing Song");
  }
}

class Player extends StatefulWidget {
  const Player({Key? key, required this.songmodel}) : super(key: key);
  final SongModel songmodel;
  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          const SizedBox(
            height: 80,
          ),
          Center(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 150,
                  child: Icon(
                    Icons.music_note,
                    size: 80,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Song Name",
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
                const Text(
                  "Artist Name",
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("0:0"),
                      Text("1:0"),
                    ],
                  ),
                ),
                Slider(value: 0.0, onChanged: (val) {}),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.skip_previous_rounded),
                      iconSize: 60,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.pause_circle_filled),
                      iconSize: 60,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.skip_next_rounded),
                      iconSize: 60,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    )));
  }
}
