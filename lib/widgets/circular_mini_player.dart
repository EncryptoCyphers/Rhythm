import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player_app/widgets/full_player.dart';
import 'package:music_player_app/pages/mini_player_and_b_nav.dart';
import 'package:music_player_app/pages/search_page.dart';
import 'package:music_player_app/pages/web.dart';
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import '../pages/mini_player.dart';
import '../services/global.dart';
import '../services/player_logic.dart';

int horizontalSwipeVariable = 0;
EdgeInsets miniPlayerPadding = const EdgeInsets.all(0);

class CircularMiniPlayer extends StatefulWidget {
  const CircularMiniPlayer({super.key});

  @override
  State<CircularMiniPlayer> createState() => _CircularMiniPlayerState();
}

class _CircularMiniPlayerState extends State<CircularMiniPlayer> {
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
                        MyClass.listIndex.value = currSongIndex;
                        debugPrint(MyClass.listIndex.value.toString());
                        if (currSongIsWeb) {
                          fetchSongUriForCurrList(currSongIndex);
                          // setState(() {
                          //   currSongList![currSongIndex].title =
                          //       currSongList![currSongIndex].title;
                          // });
                        } else {
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
                          playSong(audioPlayer: audioPlayer);
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
