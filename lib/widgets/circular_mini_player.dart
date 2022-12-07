import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_player_app/pages/full_player.dart';
import 'package:music_player_app/pages/mini_player_and_b_nav.dart';
import 'package:music_player_app/pages/search_page.dart';
import 'package:music_player_app/widgets/b_nav.dart';
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';
import '../pages/mini_player.dart';
import '../services/colours.dart';
import '../services/player_logic.dart';

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
                    onPanUpdate: (details) {
                      int sensitivity = 5;
                      if (details.delta.dy < sensitivity) {
                        // Future.delayed(Duration(milliseconds: 50), () {
                        Navigator.of(context).push(
                          PageAnimationTransition(
                              page: const Player(),
                              pageAnimationType: BottomToTopTransition()),
                        );
                        // });
                      } else if (details.delta.dy > 0) {
                        isFetchingUri.value = false;
                        audioPlayer.stop();
                        bNavPaddingListenable.value =
                            const EdgeInsets.fromLTRB(0, 0, 45, 0);
                        miniPlayerVisibilityListenable.value = false;
                      }
                      // if (details.delta.dx > 0) {
                      //   () {
                      //     if (currSongIndex >= 0 &&
                      //         currSongIndex < currSongList!.length &&
                      //         currSongList!.length > 1) {
                      //       // print(currSongIndex);

                      //       currSongIndex++;
                      //       if (currSongIsWeb) {
                      //         fetchSongUriForCurrList(currSongIndex);
                      //         // setState(() {
                      //         //   currSongList![currSongIndex].title =
                      //         //       currSongList![currSongIndex].title;
                      //         // });
                      //       } else {
                      //         getCurrSongInfo(
                      //           id: currSongList![currSongIndex].id.toString(),
                      //           uri: currSongList![currSongIndex].uri,
                      //           duration: currSongIsWeb
                      //               ? (currSongList![currSongIndex].duration)
                      //               : (Duration(
                      //                   milliseconds:
                      //                       currSongList![currSongIndex].duration)),
                      //           isWeb: currSongList![currSongIndex].isWeb,
                      //           name: currSongList![currSongIndex].title,
                      //           artist:
                      //               currSongList![currSongIndex].artist.toString(),
                      //           songIndex: currSongIndex,
                      //         );
                      //         currSongIdListenable.value =
                      //             currSongList![currSongIndex].id.toString();
                      //         playSong(audioPlayer: audioPlayer);
                      //       }
                      //     }
                      //   };
                      // } else if (details.delta.dx < -sensitivity) {
                      //   // audioPlayer.stop();
                      //   // bNavPaddingListenable.value =
                      //   //     const EdgeInsets.fromLTRB(0, 0, 45, 0);
                      //   // miniPlayerVisibilityListenable.value = false;
                      // }
                    },
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
