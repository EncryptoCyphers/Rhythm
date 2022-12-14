/*
 *  This file is part of Rhythm (https://github.com/EncryptoCyphers/Rhythm).
 * 
 * Rhythm is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Rhythm is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with Rhythm.  If not, see <http://www.gnu.org/licenses/>.
 * 
 * Copyright (c) 2022-2023, EncryptoCyphers
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player_app/widgets/full_player.dart';
import 'package:music_player_app/pages/mini_player_and_b_nav.dart';
import 'package:music_player_app/pages/search_page.dart';
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import '../pages/mini_player.dart';
import '../services/global.dart';
import '../services/player_logic.dart';

int horizontalSwipeVariable = 0;
EdgeInsets miniPlayerPadding = const EdgeInsets.all(0);
bool variable = true;

class CircularMiniPlayer extends StatefulWidget {
  const CircularMiniPlayer({super.key});

  @override
  State<CircularMiniPlayer> createState() => _CircularMiniPlayerState();
}

class _CircularMiniPlayerState extends State<CircularMiniPlayer> {
  @override
  void initState() {
    super.initState();
    audioPlayer.positionStream.listen((currPosition) {
      // if (!currSongIsWeb &&
      //     songDuration - currPosition < const Duration(milliseconds: 100)) {
      //   if (loopOfSongNotifier.value == 2) {
      //     setState(() {
      //       skipToNext();
      //     });
      //   } else if (loopOfSongNotifier.value == 1) {
      //     seekToDurationZero();
      //   } else {
      //     seekToDurationZero();
      //     audioPlayer.pause();
      //   }
      // }
      if (variable &&
          currSongIsWeb &&
          songDuration - currPosition < const Duration(milliseconds: 1000)) {
        variable = false;
        if (loopOfSongNotifier.value == 2) {
          setState(() {
            skipToNext();
          });
        } else if (loopOfSongNotifier.value == 1) {
          seekToDurationZero();
        } else {
          seekToDurationZero();
          audioPlayer.pause();
        }
        Future.delayed(const Duration(milliseconds: 1000), (() {
          variable = true;
        }));
      }
    });
    audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.playing) {
        isPlayingListenable.value = true;
      } else {
        isPlayingListenable.value = false;
      }
      if (variable &&
          !currSongIsWeb &&
          loopOfSongNotifier.value == 2 &&
          playerState.processingState == ProcessingState.completed) {
        variable = false;
        setState(() {
          skipToNext();
        });
        Future.delayed(const Duration(milliseconds: 400), () {
          variable = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: 70,
          width: 70,
          child: ValueListenableBuilder<bool>(
              valueListenable: miniPlayerVisibilityListenable,
              builder: (BuildContext context, bool playing, Widget? child) {
                if (playing) {
                  // print('affsdfasf');
                  // Future.delayed(const Duration(milliseconds: 10), () {
                  //   bNavPaddingListenable.value =
                  //       const EdgeInsets.fromLTRB(0, 0, 0, 0);
                  // });
                  return GestureDetector(
                    onPanStart: (details) {
                      horizontalSwipeVariable = 0;
                    },
                    onPanUpdate: (details) {
                      if (details.delta.dy.abs() > details.delta.dx.abs()) {
                        //print("Vertical");
                        if (details.delta.dy > 3) {
                          // print("U -> D");
                          isFetchingUri.value = false;
                          MyClass.listIndex.value = -1;
                          MyClass.localListIndex.value = -1;
                          // print(MyClass.isSelected.value);
                          audioPlayer.stop();
                          bNavPaddingListenable.value =
                              const EdgeInsets.fromLTRB(0, 0, 45, 0);
                          miniPlayerVisibilityListenable.value = false;
                        } else if (details.delta.dy < -3) {
                          //print("D -> U");
                          Navigator.of(context).push(
                            PageAnimationTransition(
                                page: const Player(),
                                pageAnimationType: BottomToTopTransition()),
                          );
                        }
                      } else if (details.delta.dy.abs() <
                          details.delta.dx.abs()) {
                        //   //print("Horizontal");
                        if (details.delta.dx < -2) {
                          //print("R -> L");
                          horizontalSwipeVariable = -1;
                        } else if (details.delta.dx > 2) {
                          //print("L -> R");
                          horizontalSwipeVariable = 1;
                        }
                      }
                    },
                    onPanEnd: (details) {
                      if (horizontalSwipeVariable == -1) {
                        skipToPrev();
                        // print("R -> L");
                        horizontalSwipeVariable = 0;
                      } else if (horizontalSwipeVariable == 1) {
                        skipToNext();
                        // print("L -> R");
                        horizontalSwipeVariable = 0;
                      }
                    },

                    // onPanUpdate: (details) {
                    //   int sensitivity = 5;
                    //   if (details.delta.dy < sensitivity) {
                    //     // Future.delayed(Duration(milliseconds: 50), () {
                    //     Navigator.of(context).push(
                    //       PageAnimationTransition(
                    //           page: const Player(),
                    //           pageAnimationType: BottomToTopTransition()),
                    //     );
                    //     // });
                    //   } else if (details.delta.dy > 0) {
                    //     isFetchingUri.value = false;
                    //     audioPlayer.stop();
                    //     bNavPaddingListenable.value =
                    //         const EdgeInsets.fromLTRB(0, 0, 45, 0);
                    //     miniPlayerVisibilityListenable.value = false;
                    //   }
                    // },
                    onTap: () {
                      if (isPlaying) {
                        isPlayingListenable.value = false;
                        audioPlayer.pause();
                      } else {
                        isPlayingListenable.value = true;
                        audioPlayer.play();
                      }
                      isPlaying = !isPlaying;
                    },
                    onDoubleTap: () {
                      if (currSongIndex >= 0 &&
                          currSongIndex < currSongList!.length &&
                          currSongList!.length > 1) {
                        // print(currSongIndex);

                        currSongIndex++;
                        debugPrint(MyClass.listIndex.value.toString());
                        if (currSongIsWeb) {
                          MyClass.listIndex.value = currSongIndex;
                          fetchSongUriForCurrList(currSongIndex);
                          // setState(() {
                          //   currSongList![currSongIndex].title =
                          //       currSongList![currSongIndex].title;
                          // });
                        } else {
                          MyClass.localListIndex.value = currSongIndex;
                          getCurrSongInfo(
                            id: currSongList![currSongIndex].id.toString(),
                            uri: currSongList![currSongIndex].uri,
                            duration: currSongIsWeb
                                ? (currSongList![currSongIndex].duration)
                                : (Duration(
                                    milliseconds:
                                        currSongList![currSongIndex].duration)),
                            isWeb: currSongList![currSongIndex].isWeb,
                            name: currSongList![currSongIndex].title,
                            artist:
                                currSongList![currSongIndex].artist.toString(),
                            songIndex: currSongIndex,
                          );
                          currSongIdListenable.value =
                              currSongList![currSongIndex].id.toString();
                          playSong(
                              // audioPlayer: audioPlayer,
                              );
                        }
                      }
                    },
                    // : ,
                    // onTap: () {
                    //   Navigator.of(context).push(
                    //     PageAnimationTransition(
                    //         page: const Player(),
                    //         pageAnimationType: BottomToTopTransition()),
                    //   );
                    // },
                    //onDoubleTap: () {
                    // skipToNext();
                    //},
                    child: const MiniArtWork(),
                  );
                } else {
                  return Container();
                }
              }),
        ),
      ],
    );
  }
}
