import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:marquee_text/marquee_text.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Player extends StatefulWidget {
  const Player({Key? key, required this.songmodel, required this.audioPlayer})
      : super(key: key);
  final SongModel songmodel;
  final AudioPlayer audioPlayer;
  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  bool _isPlaying = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    playSong();
  }

  playSong() {
    try {
      widget.audioPlayer
          .setAudioSource(AudioSource.uri(Uri.parse(widget.songmodel.uri!)));
      widget.audioPlayer.play();
      _isPlaying = true;
    } on Exception {
      log("Error Parsing Song");
    }
  }

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
                //Song Banner..........................................................//

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

                //Song Name in Marquee.......................................................................................//

                Container(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: MarqueeText(
                    text: TextSpan(
                      text: widget.songmodel.displayNameWOExt.toString(),
                    ),
                    style: const TextStyle(
                      fontSize: 28,
                    ),
                    speed: 10,
                  ),
                ),

                //Artist Name in Marquee.......................................................................................//

                Container(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: MarqueeText(
                    text: TextSpan(
                      text: widget.songmodel.artist.toString() == '<unknown>'
                          ? 'Unknown Artist'
                          : widget.songmodel.artist.toString(),
                    ),
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    speed: 10,
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                //Current and End Time of songs....................................//

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

                // PlayBack Slider ...................................................//

                Slider(value: 0.0, onChanged: (val) {}),

                //Control Buttons....................................................//

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Previous Song Button..........................................//

                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.skip_previous_rounded),
                      iconSize: 60,
                    ),

                    // Play--Pause Button.............................................//

                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (_isPlaying) {
                            widget.audioPlayer.pause();
                          } else {
                            widget.audioPlayer.play();
                          }
                          _isPlaying = !_isPlaying;
                        });
                      },
                      icon: _isPlaying
                          ? const Icon(Icons.pause_circle_filled)
                          : const Icon(Icons.play_circle_filled),
                      iconSize: 60,
                    ),

                    // Next Song Button..........................................//

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
