// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_player_app/pages/full_player.dart';
import 'package:music_player_app/pages/songs.dart';
// import 'package:music_player_app/services/data_service_and_song_query.dart';
import 'package:music_player_app/services/screen_sizes.dart';
import 'package:youtube/youtube_thumbnail.dart';
import '../services/colours.dart';
//import '../widgets/bottomNavigationBar.dart';
import '../services/get_yt_searches.dart';
import '../services/player_logic.dart';
import 'mini_player.dart';

// import 'package:flutter_media_metadata/flutter_media_metadata.dart';
Future fetchSongUri(index) async {
  isFetchingUri.value = true;
  ytSearchResultsCustom[index].uri = await getUri(
    ytSearchResultsCustom[index].videoIdForFetchStream,
  );
  playSongAfterFetch(index);
  isFetchingUri.value = false;
}

Future playSongAfterFetch(int index) async {
  isPlayingListenable.value = true;
  miniPlayerVisibilityListenable.value = true;
  currSongIdListenable.value = ytSearchResultsCustom[index].id.toString();
  getCurrSongInfo(
    id: ytSearchResultsCustom[index].id.toString(),
    duration: ytSearchResultsCustom[index].duration,
    isWeb: ytSearchResultsCustom[index].isWeb,
    uri: ytSearchResultsCustom[index].uri,
    name: ytSearchResultsCustom[index].title,
    artist: ytSearchResultsCustom[index].artist.toString(),
    songIndex: index,
    streamId: ytSearchResultsCustom[index].videoIdForFetchStream,
  );
  playSong(
    audioPlayer: audioPlayer,
  );
  getLocalMiniPlayerSongList(
    ytSearchResultsCustom,
  );
}

const platform = MethodChannel('com.example.rhythm');
ValueNotifier<bool> searchHappened = ValueNotifier(false);
ValueNotifier<bool> isSearchLoading = ValueNotifier(false);
ValueNotifier<bool> isFetchingUri = ValueNotifier(false);
bool prevSearchHappened = false;
Uint8List? albumArt;
FocusNode myFocusNode = FocusNode();

class SearchPage extends StatefulWidget {
  const SearchPage();

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
    // getMetadata();
  }

  final pageController = PageController(initialPage: 0);
  DateTime timeBackPressed = DateTime.now();

  // final _dataService = DataService();

  final _musicController = TextEditingController();

  @override
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Scaffold(
            // bottomNavigationBar: Column(
            //   mainAxisSize: MainAxisSize.min,
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     const MiniPlayerWidget(),
            //     SizedBox(
            //       height: 0,
            //       width: logicalWidth,
            //     ),
            //   ],
            // ),
            backgroundColor: Colors.white,

            // Defined in switch_pages.dart
            body:
                // Container(
                //   padding: const EdgeInsets.all(2),
                // child: Image.memory(albumArt!),
                //   child: Column(
                //     children: [
                //       // Image.memory(albumArt!),
                //       ElevatedButton(
                //         onPressed: (() {
                //           getMetadata();
                //         }),
                //         child: const Text('hii'),
                //       ),
                //     ],
                //   ),
                // ),
                Column(
              children: [
                // //
                // //
                // //
                // //......Search Bar............................
                // //
                Container(
                  padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                  child: TextField(
                    controller: _musicController,
                    onSubmitted: (value) {
                      isSearchLoading.value = true;
                      fetchSearchResults(_musicController.text);
                    },
                    focusNode: myFocusNode,
                    decoration: InputDecoration(
                      icon: IconButton(
                        onPressed: (() {
                          Navigator.pop(context);
                        }),
                        icon: const Icon(Icons.arrow_back_ios_new),
                        color: fgPurple,
                      ),
                      prefixIcon: Icon(Icons.search, color: bgPurple),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: fgPurple,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: fgPurple,
                          width: 2.5,
                        ),
                      ),
                      labelText: 'Enter a search term',
                      labelStyle: TextStyle(
                        color: bgPurple,
                      ),
                    ),
                  ),
                ),
                // //
                // //
                // //
                // //
                // //
                // //.................Main Body..................
                // //
                Flexible(
                  child: ValueListenableBuilder<bool>(
                    valueListenable: searchHappened,
                    builder: (BuildContext context, bool value, Widget? child) {
                      if (ytSearchResultsCustom.isEmpty) {
                        return ValueListenableBuilder<bool>(
                            valueListenable: isSearchLoading,
                            builder: (BuildContext context, bool value,
                                Widget? child) {
                              if (isSearchLoading.value) {
                                return const ShimmerEffect();
                              } else {
                                return SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(top: 120),
                                        child: Text(
                                          'Search Something To Show Here',
                                          style: TextStyle(
                                            color: Colors.deepPurple,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Image.asset(
                                        'images/search.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ],
                                  ),
                                );
                              }
                            });
                      } else {
                        return ValueListenableBuilder<bool>(
                            valueListenable: isSearchLoading,
                            builder: (BuildContext context, bool value,
                                Widget? child) {
                              if (isSearchLoading.value) {
                                return const ShimmerEffect();
                              } else {
                                prevSearchHappened == searchHappened.value;
                                return ListView.builder(
                                  itemCount: ytSearchResultsCustom.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding:
                                          const EdgeInsets.fromLTRB(2, 2, 2, 2),
                                      child: ListTile(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        // tileColor: Colors.black26,
                                        //
                                        //
                                        //
                                        //
                                        //...... Artwork ......................................//
                                        //
                                        leading: Image.network(YoutubeThumbnail(
                                                youtubeId:
                                                    ytSearchResultsCustom[index]
                                                        .id
                                                        .toString())
                                            .mq()),
                                        //
                                        //
                                        //
                                        //
                                        //...... Song Name  ......................................//
                                        //
                                        title: Text(
                                          ytSearchResultsCustom[index].title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        //
                                        //
                                        //
                                        //
                                        //...... Artist Name  ......................................//
                                        //
                                        subtitle: Text(
                                            ytSearchResultsCustom[index]
                                                .artist),
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
                                          // print(ytSearchResultsCustom[index]
                                          //     .videoIdForFetchStream
                                          //     .toString());
                                          fetchSongUri(index);
                                          currSongIndexListenable.value = index;
                                        },
                                      ),
                                    );
                                  },
                                );
                              }
                            });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const MiniPlayerWidget(),
            SizedBox(
              height: 0,
              width: logicalWidth,
            ),
          ],
        ),
        const LoadingSong(),
      ],
    );
  }
}

class LoadingSong extends StatelessWidget {
  const LoadingSong({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isFetchingUri,
      builder: (BuildContext context, bool value, Widget? child) {
        if (value) {
          return Center(
            child: Container(
              height: (logicalWidth * 0.16),
              width: (logicalWidth * 0.16),
              decoration: BoxDecoration(
                color: bgPurple,
                borderRadius:
                    BorderRadius.all(Radius.circular(logicalWidth * 0.05)),
              ),
              child: const CircularProgressIndicator(),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
