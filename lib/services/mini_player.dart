import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:marquee_text/marquee_text.dart';
import 'package:music_player_app/services/audioplayer.dart';
import '../pages/songs.dart';
import '../services/screen_sizes.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:on_audio_query/on_audio_query.dart';
import './colours.dart';

ValueNotifier<bool> miniPlayerVisibilityListenable = ValueNotifier<bool>(false);
ValueNotifier<bool> isPlayingListenable = ValueNotifier<bool>(false);
ValueNotifier<int> miniaudiobannerIndex = ValueNotifier<int>(0);
String songname = 'Song Name';
String artistname = 'Artist Name';
String? audioUri;
getSongInfo({required name, required artist, required uri}) {
  songname = name;
  artistname = artist;
  audioUri = uri;
}

SongModel? model;

class MiniPlayerWidget extends StatefulWidget {
  const MiniPlayerWidget({super.key, required this.audioPlayer});
  final AudioPlayer audioPlayer;
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
              minHeight: 76,
              maxHeight: logicalHeight,
              builder: (height, percentage) {
                if (height < 80) {
                  return MiniPlayerInfo(
                    audioPlayer: widget.audioPlayer,
                  );
                } else {
                  return Player(
                    songmodel: model!,
                    audioPlayer: widget.audioPlayer,
                  );
                }
              },
            );
          }
        });
  }
}

// For Mini Artwork
class MiniPlayerInfo extends StatelessWidget {
  const MiniPlayerInfo({super.key, required this.audioPlayer});
  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: miniaudiobannerIndex,
      builder: (BuildContext context, int index, Widget? child) {
        return Column(
          children: [
            ValueListenableBuilder<Duration>(
              valueListenable: songPositionListenable,
              builder:
                  (BuildContext context, Duration songPosition, Widget? child) {
                return LinearProgressIndicator(
                  backgroundColor: bgPurple,
                  color: fgPurple,
                  value: songPosition.inSeconds.toDouble() /
                      songDuration.inSeconds.toDouble(),
                );
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              leading: QueryArtworkWidget(
                nullArtworkWidget: const Icon(Icons.music_note),
                id: index,
                type: ArtworkType.AUDIO,
                artworkScale: 1,
                artworkWidth: 60,
                artworkHeight: 60,
                artworkQuality: FilterQuality.high,
              ),
              title: MarqueeText(
                text: TextSpan(
                  text: songname,
                ),
                style: const TextStyle(
                  fontSize: 18,
                ),
                speed: 10,
              ),
              subtitle: MarqueeText(
                text: TextSpan(
                  text: artistname,
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
                      color: const Color.fromARGB(255, 37, 37, 37),
                      iconSize: 35,
                      onPressed: () {
                        audioPlayer.stop();
                        miniPlayerVisibilityListenable.value = false;
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
