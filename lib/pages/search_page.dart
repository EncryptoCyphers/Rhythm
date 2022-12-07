import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_player_app/pages/full_player.dart';
import 'package:music_player_app/pages/mini_player_and_b_nav.dart';
import 'package:music_player_app/pages/songs.dart';
// import 'package:music_player_app/services/data_service_and_song_query.dart';
import 'package:music_player_app/services/screen_sizes.dart';
import 'package:music_player_app/widgets/circular_mini_player.dart';
import 'package:youtube/youtube_thumbnail.dart';
import '../services/colours.dart';
//import '../widgets/bottomNavigationBar.dart';
import '../services/get_yt_searches.dart';
import '../services/player_logic.dart';
import 'mini_player.dart';

// import 'package:flutter_media_metadata/flutter_media_metadata.dart';
Future fetchSongUri(index) async {
  audioPlayer.pause();
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
ValueNotifier<Color> statusBarColour = ValueNotifier(Colors.white);
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
        // SafeArea(
        //   child:
        Scaffold(
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              // Status bar color
              statusBarColor: Colors.white,

              // Status bar brightness (optional)
              statusBarIconBrightness:
                  Brightness.dark, // For Android (dark icons)
              statusBarBrightness: Brightness.light, // For iOS (dark icons)
            ),
            toolbarHeight: 86,
            leading: IconButton(
              onPressed: (() {
                Navigator.pop(context);
              }),
              icon: const Icon(Icons.arrow_back_ios_new),
              color: fgPurple,
            ),
            backgroundColor: Colors.white,
            title: // //
                // //
                // //
                // //......Search Bar............................
                // //
                Container(
              padding: const EdgeInsets.fromLTRB(6, 12, 5, 10),
              child: TextField(
                controller: _musicController,
                onSubmitted: (value) {
                  isSearchLoading.value = true;
                  fetchSearchResults(_musicController.text);
                },
                focusNode: myFocusNode,
                decoration: InputDecoration(
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
            elevation: 0,
            // color: Colors.transparent,
          ),
          backgroundColor: Colors.white,
          body: Column(
            children: [
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
                                child: Center(
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'images/search2.gif',
                                        width: 300,
                                      ),
                                      Text(
                                        'Search Something To Show Here',
                                        style: TextStyle(
                                          color: fgPurple,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
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
                                      leading: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(15),
                                          bottomRight: Radius.circular(5),
                                          bottomLeft: Radius.circular(15),
                                        ),
                                        child: Image.network(YoutubeThumbnail(
                                                youtubeId:
                                                    ytSearchResultsCustom[index]
                                                        .id
                                                        .toString())
                                            .mq()),
                                      ),
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
                                          ytSearchResultsCustom[index].artist),
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
                                        isPlayingListenable.value = true;
                                        bNavPaddingListenable.value =
                                            const EdgeInsets.fromLTRB(
                                                0, 0, 0, 0);
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
        // ),

        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                child: const CircularMiniPlayer()),
            SizedBox(
              height: 0,
              width: logicalWidth,
            ),
          ],
        ),
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
        if (value && playerExpandProgress.value == 76) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 72,
                // color: Colors.red,
                width: logicalWidth,
                child: Container(
                  color: Colors.white,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 25,
                      ),
                      LoadingAnimationWidget.dotsTriangle(
                        color: fgPurple,
                        // leftDotColor: const Color(0xFF1A1A3F),
                        // rightDotColor: const Color(0xFFEA3799),
                        size: 65,
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Material(
                        child: Text(
                          "Loading...",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: fgPurple),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
