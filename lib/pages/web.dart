import 'package:flutter/material.dart';
import 'package:music_player_app/pages/full_player.dart';
import 'package:music_player_app/pages/mini_player.dart';
import 'package:music_player_app/pages/songs.dart';
import 'package:music_player_app/services/data_service_and_song_query.dart';
import 'package:music_player_app/services/player_logic.dart';
import 'package:youtube/youtube_thumbnail.dart';

ValueNotifier<bool> searchHappened = ValueNotifier(false);
ValueNotifier<bool> isSearchLoading = ValueNotifier(false);
bool prevSearchHappened = false;

class WebPage extends StatefulWidget {
  const WebPage({Key? key}) : super(key: key);

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  // searchSetState() {
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: searchHappened,
        builder: (BuildContext context, bool value, Widget? child) {
          if (webSongList.isEmpty) {
            return ValueListenableBuilder<bool>(
                valueListenable: isSearchLoading,
                builder: (BuildContext context, bool value, Widget? child) {
                  if (isSearchLoading.value) {
                    return const ShimmerEffect();
                  } else {
                    return const Center(
                      child: Text('Search Something To Show Here'),
                    );
                  }
                });
          } else {
            prevSearchHappened == searchHappened.value;
            return ListView.builder(
              itemCount: webSongList.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    // tileColor: Colors.black26,
                    //
                    //
                    //
                    //
                    //...... Artwork ......................................//
                    //
                    leading: Image.network(YoutubeThumbnail(
                            youtubeId: webSongList[index].id.toString())
                        .mq()),
                    // leading: QueryArtworkWidget(
                    //   id: allSongs[index].id,
                    //   type: ArtworkType.AUDIO,
                    //   nullArtworkWidget: const Icon(Icons.music_note),
                    //   artworkBorder: const BorderRadius.all(Radius.circular(10)),
                    // ),
                    //
                    //
                    //
                    //
                    //...... Song Name  ......................................//
                    //
                    title: Text(
                      webSongList[index].title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    //
                    //
                    //
                    //
                    //...... Artist Name  ......................................//
                    //
                    subtitle: Text(webSongList[index].artist),
                    //
                    //
                    //
                    //
                    //...... left Button  ......................................//
                    //
                    trailing: const Icon(Icons.more_horiz),
                    //
                    //
                    //
                    //
                    //...... Song OnTap ......................................//
                    //
                    onTap: () {
                      // isPlayingListenable.value = true;
                      // miniPlayerVisibilityListenable.value = true;
                      // currSongIdListenable.value = webSongList[index].id;
                      // getCurrSongInfo(
                      //   id: webSongList[index].id,
                      //   uri: webSongList[index].uri,
                      //   name: webSongList[index].title,
                      //   artist: webSongList[index].artist.toString(),
                      //   songIndex: index,
                      // );
                      // playSong(audioPlayer: audioPlayer);
                      // getLocalMiniPlayerSongList(webSongList);
                    },
                  ),
                );
              },
            );
          }
        });
  }
}
