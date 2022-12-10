//import 'dart:io';
//import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:marquee_text/marquee_text.dart';
import 'package:music_player_app/pages/mini_player.dart';
import 'package:music_player_app/pages/search_page.dart';
import 'package:music_player_app/services/colours.dart';
import 'package:music_player_app/services/global.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:youtube/youtube_thumbnail.dart';
import '../services/screen_sizes.dart';
import '../services/player_logic.dart';

ValueNotifier<String> currSongIdListenable = ValueNotifier<String>(currSongId);
ValueNotifier<int> currSongIndexListenable = ValueNotifier<int>(currSongIndex);

class Player extends StatefulWidget {
  const Player({
    Key? key,
    // required this.statusBarColor,
  }) : super(key: key);
  // final Color statusBarColor;
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
    return
        // SafeArea(
        //   child:
        GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dy > 10) {
          Navigator.pop(context);
        }
        // else if (details.delta.dy > 0) {
        //   miniPlayerVisibilityListenable.value = false;
        // }
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.white,
                fgPurple,
                // fgPurple,
                veryLightPurple,
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(0.0, 1.0),
              stops: const [0.0, 0.2, 0.6, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              toolbarHeight: 0,
              backgroundColor: Colors.transparent,
              systemOverlayStyle: const SystemUiOverlayStyle(
                // Status bar color
                statusBarColor: Colors.white,

                // Status bar brightness (optional)
                statusBarIconBrightness:
                    Brightness.dark, // For Android (dark icons)
                statusBarBrightness: Brightness.light, // For iOS (dark icons)
              ),
            ),
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              // child:
              // SafeArea(
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

                          ValueListenableBuilder<int>(
                              valueListenable: currSongIndexListenable,
                              builder: (BuildContext context, int songIndex,
                                  Widget? child) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 0, 15, 0),
                                      child: MarqueeText(
                                        text: TextSpan(
                                          text: (currSongIsWeb)
                                              ? currSongList![songIndex].title
                                              : currSongName,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        style: const TextStyle(
                                          fontSize: 28,
                                        ),
                                        speed: 10,
                                      ),
                                    ),

                                    //Artist Name in Marquee.......................................................................................//

                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 0, 15, 0),
                                      child: MarqueeText(
                                        text: TextSpan(
                                          text: (currSongIsWeb)
                                              ? currSongList![songIndex].artist
                                              : currSongArtistName,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                        speed: 10,
                                      ),
                                    ),
                                  ],
                                );
                              }),

                          // Container(
                          //   padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          //   child: MarqueeText(
                          //     text: TextSpan(
                          //       text: currSongName,
                          //       style: const TextStyle(color: Colors.white),
                          //     ),
                          //     style: const TextStyle(
                          //       fontSize: 28,
                          //     ),
                          //     speed: 10,
                          //   ),
                          // ),

                          // //Artist Name in Marquee.......................................................................................//

                          // Container(
                          //   padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          //   child: MarqueeText(
                          //     text: TextSpan(
                          //       text: currSongArtistName,
                          //       style: const TextStyle(color: Colors.white),
                          //     ),
                          //     style: const TextStyle(
                          //       fontSize: 18,
                          //     ),
                          //     speed: 10,
                          //   ),
                          // ),

                          const SizedBox(
                            height: 10,
                          ),

                          //Current and End Time of songs....................................//

                          ValueListenableBuilder<Duration>(
                            valueListenable: songPositionListenable,
                            builder: (BuildContext context,
                                Duration songPosition, Widget? child) {
                              return Container(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      songPosition.toString().split(".")[0],
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      songDuration.toString().split(".")[0],
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),

                          // PlayBack Slider ...................................................//

                          ValueListenableBuilder<Duration>(
                            valueListenable: songPositionListenable,
                            builder: (BuildContext context,
                                Duration songPosition, Widget? child) {
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
                                  setState(() {
                                    skipToPrev();
                                  });
                                },
                                color: Colors.white,
                                icon: const Icon(Icons.skip_previous_rounded),
                                iconSize: 60,
                              ),

                              // Play--Pause Button.............................................//

                              Stack(
                                children: [
                                  ValueListenableBuilder<bool>(
                                      valueListenable: isFetchingUri,
                                      builder: (BuildContext context,
                                          bool isFetching, Widget? child) {
                                        if (isFetching) {
                                          return Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                5.5, 5.5, 0, 0),
                                            child: LoadingAnimationWidget
                                                .threeArchedCircle(
                                              color: Colors.white,
                                              size: 65,
                                            ),
                                          );
                                        } else {
                                          return Container();
                                        }
                                      }),
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
                                ],
                              ),

                              // Next Song Button..........................................//

                              IconButton(
                                onPressed: () {
                                  if (currSongIndex >= 0 &&
                                      currSongIndex <
                                          currSongList!.length - 1 &&
                                      currSongList!.length > 1) {
                                    audioPlayer.pause();
                                    // print(currSongIndex);
                                    setState(() {
                                      currSongIndex++;
                                      MyClass.listIndex.value = currSongIndex;
                                    });
                                    if (currSongIsWeb) {
                                      currSongIndexListenable.value =
                                          currSongIndex;
                                      fetchSongUriForCurrList(currSongIndex);
                                    } else {
                                      getCurrSongInfo(
                                        id: currSongList![currSongIndex]
                                            .id
                                            .toString(),
                                        duration: currSongIsWeb
                                            ? (currSongList![currSongIndex]
                                                .duration)
                                            : (Duration(
                                                milliseconds:
                                                    currSongList![currSongIndex]
                                                        .duration)),
                                        isWeb:
                                            currSongList![currSongIndex].isWeb,
                                        uri: currSongList![currSongIndex].uri,
                                        name:
                                            currSongList![currSongIndex].title,
                                        artist: currSongList![currSongIndex]
                                            .artist
                                            .toString(),
                                        songIndex: currSongIndex,
                                      );
                                      currSongIdListenable.value =
                                          currSongList![currSongIndex]
                                              .id
                                              .toString();
                                      playSong(audioPlayer: audioPlayer);
                                      setState(() {
                                        currSongList![currSongIndex].title =
                                            currSongList![currSongIndex].title;
                                      });
                                    }
                                  }
                                  setState(() {
                                    skipToNext();
                                  });
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
              ),
              // ),
            )),
        // ),
      ),
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
    return ValueListenableBuilder<bool>(
        valueListenable: isFetchingUri,
        builder: (BuildContext context, bool isFetching, Widget? child) {
          if (isFetching) {
            return SizedBox(
              height: 200,
              width: logicalWidth * 0.8,
              child: LoadingAnimationWidget.prograssiveDots(
                  color: Colors.white, size: 150),
            );
          } else {
            return ValueListenableBuilder<String>(
              valueListenable: currSongIdListenable,
              builder:
                  (BuildContext context, String currSongId, Widget? child) {
                if (currSongIsWeb) {
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(20),
                        ),
                        child: SizedBox(
                          // color: Colors.amber,
                          height: 200,
                          width: logicalWidth * 0.8,
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: Image.network(
                              YoutubeThumbnail(youtubeId: currSongId.toString())
                                  .hd(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return QueryArtworkWidget(
                  nullArtworkWidget: SizedBox(
                    height: logicalWidth * 0.75,
                    width: logicalWidth * 0.75,
                    child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: Image.asset(
                            'svg/No-Artwork-square-transparent.png')),
                  ),
                  id: int.parse(currSongId),
                  type: ArtworkType.AUDIO,
                  artworkQuality: FilterQuality.high,
                  artworkHeight: logicalWidth * 0.75,
                  artworkWidth: logicalWidth * 0.75,
                );
              },
            );
          }
        });
  }
}
