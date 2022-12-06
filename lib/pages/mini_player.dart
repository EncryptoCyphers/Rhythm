import 'package:flutter/material.dart';
import 'package:marquee_text/marquee_text.dart';
import 'package:music_player_app/pages/full_player.dart';
import 'package:music_player_app/pages/search_page.dart';
import 'package:youtube/youtube_thumbnail.dart';
import '../services/data_service_and_song_query.dart';
import '../services/get_yt_searches.dart';
import '../services/screen_sizes.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../services/colours.dart';
import '../services/player_logic.dart';

Future fetchSongUriForCurrList(index) async {
  isFetchingUri.value = true;
  currSongList![index].uri = await getUri(
    currSongList![index].videoIdForFetchStream,
  );
  playSongAfterFetch(index);
  isFetchingUri.value = false;
}

Future playSongAfterFetch(int index) async {
  isPlayingListenable.value = true;
  miniPlayerVisibilityListenable.value = true;
  currSongIdListenable.value = currSongList![index].id.toString();
  getCurrSongInfo(
    id: currSongList![index].id.toString(),
    duration: currSongList![index].duration,
    isWeb: currSongList![index].isWeb,
    uri: currSongList![index].uri,
    name: currSongList![index].title,
    artist: currSongList![index].artist.toString(),
    songIndex: index,
    streamId: currSongList![index].videoIdForFetchStream,
  );
  playSong(
    audioPlayer: audioPlayer,
  );
}

List<CustomSongModel>? currSongList;
getLocalMiniPlayerSongList(List<CustomSongModel> item) {
  currSongList = item;
}

ValueNotifier<double> playerExpandProgress = ValueNotifier(76);

ValueNotifier<bool> miniPlayerVisibilityListenable = ValueNotifier<bool>(false);
ValueNotifier<bool> isPlayingListenable = ValueNotifier<bool>(false);

class MiniPlayerWidget extends StatefulWidget {
  const MiniPlayerWidget({
    // required this.statusBarColor,
    super.key,
  });
  // final Color statusBarColor;

  @override
  State<MiniPlayerWidget> createState() => _MiniPlayerWidgetState();
}

class _MiniPlayerWidgetState extends State<MiniPlayerWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ValueListenableBuilder<bool>(
            valueListenable: miniPlayerVisibilityListenable,
            builder: (BuildContext context, bool playing, Widget? child) {
              if (!playing) {
                return SizedBox(
                  height: 0,
                  width: logicalWidth,
                );
              } else {
                return Miniplayer(
                  onDismissed: () {
                    audioPlayer.stop();
                    miniPlayerVisibilityListenable.value = false;
                  },
                  valueNotifier: playerExpandProgress,
                  minHeight: 76,
                  maxHeight: logicalHeight,
                  builder: (height, percentage) {
                    // playerExpandProgress.value = height;
                    if (height < 100) {
                      return const MiniPlayerInfo();
                    } else {
                      return const Player();
                    }
                  },
                );
              }
            }),
        const LoadingSong()
      ],
    );
  }
}

// For Mini Artwork
class MiniPlayerInfo extends StatelessWidget {
  const MiniPlayerInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: currSongIdListenable,
      builder: (BuildContext context, String index, Widget? child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ValueListenableBuilder<Duration>(
              valueListenable: songPositionListenable,
              builder:
                  (BuildContext context, Duration songPosition, Widget? child) {
                return SizedBox(
                  height: 3,
                  child: LinearProgressIndicator(
                    minHeight: 2,
                    backgroundColor: bgPurple,
                    color: fgPurple,
                    value: songPosition.inSeconds.toDouble() /
                        songDuration.inSeconds.toDouble(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 73,
              child: ListTile(
                contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                leading: const MiniArtWork(),
                title: MarqueeText(
                  text: TextSpan(
                    text: currSongName,
                  ),
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                  speed: 10,
                ),
                subtitle: MarqueeText(
                  text: TextSpan(
                    text: currSongArtistName,
                  ),
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  speed: 10,
                ),
                trailing: SizedBox(
                  height: 70,
                  width: 107,
                  child: Row(
                    children: [
                      IconButton(
                        color: const Color.fromARGB(255, 37, 37, 37),
                        iconSize: 40,
                        onPressed: () {
                          if (isPlaying) {
                            isPlayingListenable.value = false;
                            audioPlayer.pause();
                          } else {
                            isPlayingListenable.value = true;
                            audioPlayer.play();
                          }
                          isPlaying = !isPlaying;
                        },
                        icon: ValueListenableBuilder<bool>(
                          builder: (BuildContext context,
                              bool isPlayingListenable, Widget? child) {
                            if (isPlaying) {
                              return const Icon(Icons.pause);
                            } else {
                              return const Icon(Icons.play_arrow);
                            }
                          },
                          valueListenable: isPlayingListenable,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
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
                                            currSongList![currSongIndex]
                                                .duration)),
                                isWeb: currSongList![currSongIndex].isWeb,
                                name: currSongList![currSongIndex].title,
                                artist: currSongList![currSongIndex]
                                    .artist
                                    .toString(),
                                songIndex: currSongIndex,
                              );
                              currSongIdListenable.value =
                                  currSongList![currSongIndex].id.toString();
                              playSong(audioPlayer: audioPlayer);
                            }
                          }
                        },
                        color: const Color.fromARGB(255, 37, 37, 37),
                        iconSize: 35,
                        icon: const Icon(Icons.skip_next_rounded),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class MiniArtWork extends StatelessWidget {
  const MiniArtWork({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: currSongIdListenable,
      builder: (BuildContext context, String currSongId, Widget? child) {
        if (currSongIsWeb) {
          return ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(15),
              bottomRight: Radius.circular(5),
              bottomLeft: Radius.circular(15),
            ),
            child: Image.network(
                YoutubeThumbnail(youtubeId: currSongId.toString()).mq()),
          );
        }
        return QueryArtworkWidget(
          nullArtworkWidget: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        // Colors.white,
                        veryLightPurple,
                        fgPurple,
                        Colors.white,
                        // fgPurple,
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(0.0, 1.0),
                      stops: const [0.0, 0.6, 1.0],
                      tileMode: TileMode.clamp),
                ),
                height: 70,
                width: 70,
                // color: Colors.white,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(5.5, 4, 5, 7),
                  child: Image.asset(
                    'svg/No-Artwork-square-transparent.png',
                    fit: BoxFit.contain,
                  ),
                )),
          ),
          id: int.parse(currSongId),
          type: ArtworkType.AUDIO,
          artworkQuality: FilterQuality.high,
          artworkHeight: 60,
          artworkWidth: 60,
          artworkBorder: const BorderRadius.all(Radius.circular(30)),
        );
      },
    );
  }
}
