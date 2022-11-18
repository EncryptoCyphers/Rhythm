//import 'dart:io';
//import 'dart:typed_data';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:marquee_text/marquee_text.dart';
import 'package:music_player_app/services/mini_player.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../pages/songs.dart';
import '../services/screen_sizes.dart';

// bool of is Playing
bool isPlaying = false;
//To build the SongBanner Outside.......................//Fixed: Flickring Banner Problem..................//

int audiobannerIndex = 0;
String? audiobannerUri = "";
QueryArtworkWidget artwork = QueryArtworkWidget(
  nullArtworkWidget: const Icon(Icons.music_note),
  id: audiobannerIndex,
  type: ArtworkType.AUDIO,
  artworkQuality: FilterQuality.high,
);
getaudiobannerindex({required String? uri, required int index}) {
  audiobannerIndex = index;
  audiobannerUri = uri;
  artwork = QueryArtworkWidget(
    nullArtworkWidget: const Icon(Icons.music_note),
    id: audiobannerIndex,
    type: ArtworkType.AUDIO,
    artworkScale: 5,
    artworkWidth: (logicalWidth * 0.8),
    artworkHeight: (logicalWidth * 0.8),
    artworkQuality: FilterQuality.high,
  );
}

class Player extends StatefulWidget {
  const Player({
    Key? key,
    required this.songmodel,
    required this.audioPlayer,
  }) : super(key: key);
  final SongModel songmodel;
  final AudioPlayer audioPlayer;
  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  //checks if Player is actually playing...............................................................................//

  @override
  void initState() {
    super.initState();
    // playSong();
  }
  //Method to play Song..................................................................//

  // playSong() {
  //   try {
  //     widget.audioPlayer
  //         .setAudioSource(AudioSource.uri(Uri.parse(widget.songmodel.uri!)));
  //     widget.audioPlayer.play();
  //     isPlaying = true;
  //   } on Exception {
  //     log("Error Parsing Song");
  //   }
  //   widget.audioPlayer.durationStream.listen((duration) {
  //     setState(() {
  //       _duration = duration!;
  //     });
  //   });
  //   widget.audioPlayer.positionStream.listen((currPosition) {
  //     setState(() {
  //       _position = currPosition;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Colors.white,
              Color.fromARGB(255, 208, 176, 224),
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(0.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: SafeArea(
                child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // IconButton(
                  //   onPressed: () {
                  //     Navigator.pop(context);
                  //   },
                  //   icon: const Icon(Icons.arrow_back_ios_new),
                  // ),
                  const SizedBox(
                    height: 60,
                  ),
                  Center(
                    child: Column(
                      children: [
                        //Song Banner..........................................................//

                        artwork,
                        //Song Name in Marquee.......................................................................................//
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: MarqueeText(
                            text: TextSpan(
                              text:
                                  widget.songmodel.displayNameWOExt.toString(),
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
                              text: widget.songmodel.artist.toString() ==
                                      '<unknown>'
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

                        ValueListenableBuilder<Duration>(
                          valueListenable: songPositionListenable,
                          builder: (BuildContext context, Duration songPosition,
                              Widget? child) {
                            return Container(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(songPosition.toString().split(".")[0]),
                                  Text(songDuration.toString().split(".")[0]),
                                ],
                              ),
                            );
                          },
                        ),

                        // PlayBack Slider ...................................................//

                        ValueListenableBuilder<Duration>(
                          valueListenable: songPositionListenable,
                          builder: (BuildContext context, Duration songPosition,
                              Widget? child) {
                            return Slider(
                                min: const Duration(microseconds: 0)
                                    .inSeconds
                                    .toDouble(),
                                value: songPosition.inSeconds.toDouble(),
                                max: songDuration.inSeconds.toDouble(),
                                onChanged: (val) {
                                  setState(() {
                                    changeToSeconds(val.toInt());
                                    val = val;
                                  });
                                });
                          },
                        ),

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
                                  if (isPlaying) {
                                    isPlayingListenable.value = false;
                                    widget.audioPlayer.pause();
                                  } else {
                                    isPlayingListenable.value = true;
                                    widget.audioPlayer.play();
                                  }
                                  isPlaying = !isPlaying;
                                });
                              },
                              icon: isPlaying
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
            )),
          )),
    );
  }

  changeToSeconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    widget.audioPlayer.seek(duration);
  }
}
