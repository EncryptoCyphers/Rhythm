// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_player_app/pages/songs.dart';
import 'package:music_player_app/services/data_service_and_song_query.dart';
import 'package:music_player_app/services/screen_sizes.dart';
import 'package:youtube/youtube_thumbnail.dart';
import '../services/colours.dart';
//import '../widgets/bottomNavigationBar.dart';
import '../services/get_yt_searches.dart';
import 'mini_player.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

ValueNotifier<bool> searchHappened = ValueNotifier(false);
ValueNotifier<bool> isSearchLoading = ValueNotifier(false);
bool prevSearchHappened = false;

class SearchPage extends StatefulWidget {
  const SearchPage();

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final pageController = PageController(initialPage: 0);
  DateTime timeBackPressed = DateTime.now();

  final _dataService = DataService();

  final _musicController = TextEditingController();

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: fgPurple,

          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        backgroundColor: fgPurple,
        /*centerTitle: true,
            title: const Text("RYTHM"),*/
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: SearchBarAnimation(
                  textEditingController: _musicController,
                  isOriginalAnimation: true,
                  durationInMilliSeconds: 300,
                  trailingWidget: const Icon(Icons.search),
                  secondaryButtonWidget: const Icon(Icons.close),
                  buttonWidget: const Icon(Icons.search),
                  isSearchBoxOnRightSide: true,
                  hintText: "Search Songs, Artists...",
                  //hintTextColour: Colors.deepPurple,
                  enableKeyboardFocus: true,
                  onFieldSubmitted: (String value) {
                    isSearchLoading.value = true;
                    fetchSearchResults(_musicController.text);
                    _dataService.getMusic(_musicController.text);
                  }),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const MiniPlayerWidget(),
          SizedBox(
            height: 0,
            width: logicalWidth,
          ),
        ],
      ),
      backgroundColor: Colors.white,

      // Defined in switch_pages.dart
      body: ValueListenableBuilder<bool>(
          valueListenable: searchHappened,
          builder: (BuildContext context, bool value, Widget? child) {
            if (ytSearchResults.isEmpty) {
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
              return ValueListenableBuilder<bool>(
                  valueListenable: isSearchLoading,
                  builder: (BuildContext context, bool value, Widget? child) {
                    if (isSearchLoading.value) {
                      return const ShimmerEffect();
                    } else {
                      prevSearchHappened == searchHappened.value;
                      return ListView.builder(
                        itemCount: ytSearchResults.length,
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
                                      youtubeId:
                                          ytSearchResults[index].id.toString())
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
                                ytSearchResults[index].title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              //
                              //
                              //
                              //
                              //...... Artist Name  ......................................//
                              //
                              subtitle: Text(ytSearchResults[index].author),
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
                                // currSongIdListenable.value = ytSearchResults[index].id;
                                // getCurrSongInfo(
                                //   id: ytSearchResults[index].id,
                                //   uri: ytSearchResults[index].uri,
                                //   name: ytSearchResults[index].title,
                                //   artist: ytSearchResults[index].artist.toString(),
                                //   songIndex: index,
                                // );
                                // playSong(audioPlayer: audioPlayer);
                                // getLocalMiniPlayerSongList(ytSearchResults);
                              },
                            ),
                          );
                        },
                      );
                    }
                  });

              // prevSearchHappened == searchHappened.value;
              // return ListView.builder(
              //   itemCount: ytSearchResults.length,
              //   itemBuilder: (context, index) {
              //     return Container(
              //       padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
              //       child: ListTile(
              //         shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(20)),
              //         // tileColor: Colors.black26,
              //         //
              //         //
              //         //
              //         //
              //         //...... Artwork ......................................//
              //         //
              //         leading: Image.network(YoutubeThumbnail(
              //                 youtubeId: ytSearchResults[index].id.toString())
              //             .mq()),
              //         // leading: QueryArtworkWidget(
              //         //   id: allSongs[index].id,
              //         //   type: ArtworkType.AUDIO,
              //         //   nullArtworkWidget: const Icon(Icons.music_note),
              //         //   artworkBorder: const BorderRadius.all(Radius.circular(10)),
              //         // ),
              //         //
              //         //
              //         //
              //         //
              //         //...... Song Name  ......................................//
              //         //
              //         title: Text(
              //           ytSearchResults[index].title,
              //           maxLines: 1,
              //           overflow: TextOverflow.ellipsis,
              //         ),
              //         //
              //         //
              //         //
              //         //
              //         //...... Artist Name  ......................................//
              //         //
              //         subtitle: Text(ytSearchResults[index].artist),
              //         //
              //         //
              //         //
              //         //
              //         //...... left Button  ......................................//
              //         //
              //         trailing: const Icon(Icons.more_horiz),
              //         //
              //         //
              //         //
              //         //
              //         //...... Song OnTap ......................................//
              //         //
              //         onTap: () {
              //           // isPlayingListenable.value = true;
              //           // miniPlayerVisibilityListenable.value = true;
              //           // currSongIdListenable.value = ytSearchResults[index].id;
              //           // getCurrSongInfo(
              //           //   id: ytSearchResults[index].id,
              //           //   uri: ytSearchResults[index].uri,
              //           //   name: ytSearchResults[index].title,
              //           //   artist: ytSearchResults[index].artist.toString(),
              //           //   songIndex: index,
              //           // );
              //           // playSong(audioPlayer: audioPlayer);
              //           // getLocalMiniPlayerSongList(ytSearchResults);
              //         },
              //       ),
              //     );
              //   },
              // );
            }
          }),
    );
  }
}
