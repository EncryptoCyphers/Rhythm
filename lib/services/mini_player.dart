import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:marquee_text/marquee_text.dart';
import 'package:music_player_app/services/audioplayer.dart';
import '../services/screen_sizes.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:on_audio_query/on_audio_query.dart';

ValueNotifier<bool> isPlayingValueListenable = ValueNotifier<bool>(false);
ValueNotifier<int> miniaudiobannerIndex = ValueNotifier<int>(0);
String songname = 'Song Name';
String artistname = 'Artist Name';

getSongInfo({required name, required artist}) {
  songname = name;
  artistname = artist;
}

SongModel? model;

class MiniPlayerWidget extends StatefulWidget {
  const MiniPlayerWidget({super.key, required this.audioPlayer});
  final AudioPlayer audioPlayer;
  @override
  State<MiniPlayerWidget> createState() => _MiniPlayerWidgetState();
}

class _MiniPlayerWidgetState extends State<MiniPlayerWidget> {
  // @override
  // void initState() {
  //   super.initState();
  //   playSong();
  // }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: isPlayingValueListenable,
        builder: (BuildContext context, bool playing, Widget? child) {
          if (!playing) {
            return SizedBox(
              height: 0,
              width: logicalWidth,
            );
          } else {
            return Miniplayer(
              minHeight: 70,
              maxHeight: logicalHeight,
              builder: (height, percentage) {
                if (height < 80) {
                  return const MiniPlayerInfo();
                }
                // else if (height == logicalHeight) {
                //   // Navigator.push(
                //   //   context,
                //   //   MaterialPageRoute(
                //   //     builder: (context) => Player(
                //   //       songmodel: model!,
                //   //       audioPlayer: widget.audioPlayer,
                //   //     ),
                //   //   ),
                //   // );
                //   return Player(
                //     songmodel: model!,
                //     audioPlayer: widget.audioPlayer,
                //   );
                // }
                else {
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
  const MiniPlayerInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: miniaudiobannerIndex,
      builder: (BuildContext context, int index, Widget? child) {
        return ListTile(
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
            width: 96,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.play_arrow),
                ),
                IconButton(
                  onPressed: () {
                    isPlayingValueListenable.value = false;
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
        );
        //   QueryArtworkWidget(
        //     nullArtworkWidget: const Icon(Icons.music_note),
        //     id: index,
        //     type: ArtworkType.AUDIO,
        //     artworkScale: 1,
        //     artworkWidth: 60,
        //     artworkHeight: 60,
        //     artworkQuality: FilterQuality.high,
        //   );
        // },
      },
    );
  }
}
