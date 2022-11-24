import 'package:flutter/material.dart';
import 'package:marquee_text/marquee_text.dart';
import 'package:music_player_app/pages/full_player.dart';
import '../services/screen_sizes.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../services/colours.dart';
import '../services/player_logic.dart';

List<SongModel>? localList;
getLocalMiniPlayerSongList(List<SongModel> item) {
  localList = item;
}

ValueNotifier<double> playerExpandProgress = ValueNotifier(76);

ValueNotifier<bool> miniPlayerVisibilityListenable = ValueNotifier<bool>(false);
ValueNotifier<bool> isPlayingListenable = ValueNotifier<bool>(false);

class MiniPlayerWidget extends StatefulWidget {
  const MiniPlayerWidget({super.key});
  @override
  State<MiniPlayerWidget> createState() => _MiniPlayerWidgetState();
}

class _MiniPlayerWidgetState extends State<MiniPlayerWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
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
        });
  }
}

// For Mini Artwork
class MiniPlayerInfo extends StatelessWidget {
  const MiniPlayerInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: currSongIdListenable,
      builder: (BuildContext context, int index, Widget? child) {
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
                              currSongIndex < localList!.length &&
                              localList!.length > 1) {
                            // print(currSongIndex);

                            currSongIndex++;
                            getCurrSongInfo(
                              id: localList![currSongIndex].id,
                              uri: localList![currSongIndex].uri,
                              name: localList![currSongIndex].displayNameWOExt,
                              artist:
                                  localList![currSongIndex].artist.toString(),
                              songIndex: currSongIndex,
                            );
                            currSongIdListenable.value =
                                localList![currSongIndex].id;
                            playSong(audioPlayer: audioPlayer);
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
    return ValueListenableBuilder<int>(
      valueListenable: currSongIdListenable,
      builder: (BuildContext context, int currSongId, Widget? child) {
        return QueryArtworkWidget(
          nullArtworkWidget: const Icon(Icons.music_note),
          id: currSongId,
          type: ArtworkType.AUDIO,
          artworkQuality: FilterQuality.high,
          artworkHeight: 60,
          artworkWidth: 60,
        );
      },
    );
  }
}
