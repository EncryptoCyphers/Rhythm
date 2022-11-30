//import 'dart:io';
//import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:marquee_text/marquee_text.dart';
import 'package:music_player_app/pages/mini_player.dart';
import 'package:music_player_app/services/colours.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'songs.dart';
import '../services/screen_sizes.dart';
import '../services/player_logic.dart';

ValueNotifier<int> currSongIdListenable = ValueNotifier<int>(currSongId);

class Player extends StatefulWidget {
  const Player({
    Key? key,
  }) : super(key: key);
  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              fgPurple,
              fgPurple,
              veryLightPurple,
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.0, 1.0),
            stops: const [0.0, 0.6, 1.0],
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

                        const ArtWork(),
                        //Song Name in Marquee.......................................................................................//
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: MarqueeText(
                            text: TextSpan(
                              text: currSongName,
                              style: const TextStyle(color: Colors.white),
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
                              text: currSongArtistName,
                              style: const TextStyle(color: Colors.white),
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
                                  Text(
                                    songPosition.toString().split(".")[0],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    songDuration.toString().split(".")[0],
                                    style: const TextStyle(color: Colors.white),
                                  ),
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
                                activeColor: Colors.white,
                                inactiveColor: veryLightPurple,
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
                              onPressed: () {
                                if (currSongIndex > 0 &&
                                    currSongIndex <= currSongList!.length &&
                                    currSongList!.length > 1) {
                                  // print(currSongIndex);
                                  setState(() {
                                    currSongIndex--;
                                  });
                                  getCurrSongInfo(
                                    id: currSongList![currSongIndex].id,
                                    uri: currSongList![currSongIndex].uriLocal,
                                    name: currSongList![currSongIndex].title,
                                    artist: currSongList![currSongIndex]
                                        .artist
                                        .toString(),
                                    songIndex: currSongIndex,
                                  );
                                  currSongIdListenable.value =
                                      currSongList![currSongIndex].id;
                                  playSong(audioPlayer: audioPlayer);
                                }
                              },
                              color: Colors.white,
                              icon: const Icon(Icons.skip_previous_rounded),
                              iconSize: 60,
                            ),

                            // Play--Pause Button.............................................//

                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (isPlaying) {
                                    isPlayingListenable.value = false;
                                    audioPlayer.pause();
                                  } else {
                                    isPlayingListenable.value = true;
                                    audioPlayer.play();
                                  }
                                  isPlaying = !isPlaying;
                                });
                              },
                              color: Colors.white,
                              icon: isPlaying
                                  ? const Icon(Icons.pause_circle_filled)
                                  : const Icon(Icons.play_circle_filled),
                              iconSize: 60,
                            ),

                            // Next Song Button..........................................//

                            IconButton(
                              onPressed: () {
                                if (currSongIndex >= 0 &&
                                    currSongIndex < currSongList!.length &&
                                    currSongList!.length > 1) {
                                  // print(currSongIndex);
                                  setState(() {
                                    currSongIndex++;
                                  });
                                  getCurrSongInfo(
                                    id: currSongList![currSongIndex].id,
                                    uri: currSongList![currSongIndex].uriLocal,
                                    name: currSongList![currSongIndex].title,
                                    artist: currSongList![currSongIndex]
                                        .artist
                                        .toString(),
                                    songIndex: currSongIndex,
                                  );
                                  currSongIdListenable.value =
                                      currSongList![currSongIndex].id;
                                  playSong(audioPlayer: audioPlayer);
                                }
                              },
                              color: Colors.white,
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
    audioPlayer.seek(duration);
  }
}

class ArtWork extends StatelessWidget {
  const ArtWork({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: currSongIdListenable,
      builder: (BuildContext context, int currSongId, Widget? child) {
        return QueryArtworkWidget(
          nullArtworkWidget: const Icon(Icons.music_note),
          id: currSongId,
          type: ArtworkType.AUDIO,
          artworkQuality: FilterQuality.high,
          artworkHeight: logicalWidth * 0.75,
          artworkWidth: logicalWidth * 0.75,
        );
      },
    );
  }
}
