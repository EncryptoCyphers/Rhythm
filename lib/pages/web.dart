/*
 *  This file is part of Rhythm (https://github.com/EncryptoCyphers/Rhythm).
 * 
 * Rhythm is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Rhythm is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with Rhythm.  If not, see <http://www.gnu.org/licenses/>.
 * 
 * Copyright (c) 2022-2023, EncryptoCyphers
 */
import 'package:flutter/material.dart';
//import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_player_app/widgets/full_player.dart';
import 'package:music_player_app/pages/mini_player.dart';
import 'package:music_player_app/pages/mini_player_and_b_nav.dart';
import 'package:music_player_app/pages/search_page.dart';
import 'package:music_player_app/services/colours.dart';
import 'package:music_player_app/services/player_logic.dart';
// import 'package:music_player_app/pages/full_player.dart';
// import 'package:music_player_app/pages/mini_player.dart';
import 'package:music_player_app/services/trending_songs.dart';
import 'package:youtube/youtube_thumbnail.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../services/get_yt_searches.dart';
import '../services/global.dart';

// import '../services/get_yt_searches.dart';
// import '../services/player_logic.dart';

// ignore: must_be_immutable

Future fetchSongUriWeb(index) async {
  audioPlayer.pause();
  isFetchingUri.value = true;
  trendingSongList[index].videoIdForFetchStream =
      VideoId(trendingSongList[index].id.toString());
  trendingSongList[index].uri = await getUri(
    trendingSongList[index].videoIdForFetchStream,
  );
  playSongAfterFetchWeb(index);
  isFetchingUri.value = false;
}

Future playSongAfterFetchWeb(int index) async {
  isPlayingListenable.value = true;
  miniPlayerVisibilityListenable.value = true;
  currSongIdListenable.value = trendingSongList[index].id.toString();
  getCurrSongInfo(
    id: trendingSongList[index].id.toString(),
    duration: trendingSongList[index].duration,
    isWeb: trendingSongList[index].isWeb,
    uri: trendingSongList[index].uri,
    name: trendingSongList[index].title,
    artist: trendingSongList[index].artist.toString(),
    songIndex: index,
    streamId: trendingSongList[index].videoIdForFetchStream,
  );
  playSong(
      // audioPlayer: audioPlayer,
      );
  getLocalMiniPlayerSongList(
    trendingSongList,
  );
}

class Youtube extends StatefulWidget {
  const Youtube({super.key});

  @override
  State<Youtube> createState() => _YoutubeState();
}

class _YoutubeState extends State<Youtube> {
  void listTileColorChange(int index) {
    MyClass.listIndex.value = index;
    MyClass.firstLoad = false;
    MyClass.dismissedSong = false;
    MyClass.localListIndex.value = -1;
    if (index == MyClass.listIndex.value &&
        MyClass.firstLoad == false &&
        MyClass.dismissedSong == false) {
      MyClass.isSelected.value = true;
      return;
    }
    MyClass.isSelected.value = false;
    // print(firstLoad);
  }

  Widget iconSelector(int index, int listIndexValue) {
    if (index == listIndexValue &&
        MyClass.firstLoad == false &&
        MyClass.dismissedSong == false) {
      return const Icon(Icons.bar_chart_rounded);
    }
    return Text(
      trendingSongList[index].duration.toString().substring(3, 7),
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: fgPurple,
      ),
    );
  }

  Trending trending = Trending();

  /*
  @override
  void initState() {
    super.initState();
    trending.getTrendingMusic();
    print(trendingSongList[0].title);
  }
  */
  final List<String> imageList = [];
  Future<void> makeTrendingSongList() async {
    //await Future.delayed(const Duration(seconds: 2));
    await trending.getTrendingMusic();
    for (int i = 0; i < trendingSongList.length; i++) {
      imageList.add(trendingSongList[i].id);
    }
    // print(imageList);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /*
                /*-----------------------------------Text Box-----------------------------------*/
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                  child: Text(
                    'Trending Songs on YouTube',
                    style: GoogleFonts.laila(
                      color: Colors.deepPurple,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                /*-----------------------------------Trending Song-----------------------------------*/
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: FutureBuilder(
                      future: makeTrendingSongList(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: LoadingAnimationWidget.dotsTriangle(
                              color: Colors.deepPurple,
                              size: 50,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return const Text(
                            'Something went wrong!!',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          );
                        }
                        return CarouselSlider(
                          options: CarouselOptions(
                            autoPlay: true,
                            enlargeCenterPage: true,
                          ),
                          items: trendingSongList.map((trendingSong) {
                            int index = trendingSongList.indexOf(trendingSong);
                            return GestureDetector(
                              onTap: () {
                                // print(index);
                                isPlayingListenable.value = true;
                                bNavPaddingListenable.value =
                                    const EdgeInsets.fromLTRB(0, 0, 0, 0);
                                // print(trendingSongList[index]
                                //     .videoIdForFetchStream
                                //     .toString());
                                fetchSongUriWeb(index);
                                currSongIndexListenable.value = index;
                              },
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(7),
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(7),
                                  bottomLeft: Radius.circular(20),
                                ),
                                child: Image.network(
                                  YoutubeThumbnail(youtubeId: trendingSong.id)
                                      .hd(),
                                  // scale: 0.7,
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      }),
                ),
                */
                /*-----------------------------------Text Box-----------------------------------*/
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                  child: Text(
                    'Trending Songs on YouTube',
                    style: GoogleFonts.laila(
                      color: Colors.deepPurple,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          /*-----------------------------------Trending Songs-----------------------------------*/
          FutureBuilder(
            future: makeTrendingSongList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: Center(
                    child: LoadingAnimationWidget.inkDrop(
                      color: Colors.deepPurple,
                      size: 50,
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return const Text(
                  'Something went wrong!!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                );
              }
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.815,
                child: ValueListenableBuilder(
                  valueListenable: MyClass.listIndex,
                  builder: (context, value, child) {
                    return ListView.builder(
                      padding: const EdgeInsets.only(bottom: 75),
                      itemCount: trendingSongList.length,
                      itemBuilder: (context, index) {
                        // return GFListTile(
                        //   avatar: Image(
                        //     image: NetworkImage(
                        //         YoutubeThumbnail(youtubeId: imageList[index]).mq()),
                        //     width: 90,
                        //     height: 100,
                        //     fit: BoxFit.cover,
                        //   ),
                        //   titleText: trendingSongList[index].title,
                        //   subTitleText: trendingSongList[index].artist,
                        //   icon: const FaIcon(
                        //     FontAwesomeIcons.youtube,
                        //     color: Colors.red,
                        //   ),
                        // );
                        return ListTile(
                          contentPadding: const EdgeInsets.only(
                            bottom: 10,
                            left: 10,
                            right: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          leading: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(5),
                              bottomLeft: Radius.circular(15),
                            ),
                            child: Image.network(
                              YoutubeThumbnail(
                                youtubeId: imageList[index],
                              ).mq(),
                              fit: BoxFit.cover,
                              width: 90,
                              height: 90,
                            ),
                          ),
                          title: Text(
                            trendingSongList[index].title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            trendingSongList[index].artist,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 170, 80, 249),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing:
                              iconSelector(index, MyClass.listIndex.value),
                          onTap: () {
                            listTileColorChange(index);
                            isPlayingListenable.value = true;
                            bNavPaddingListenable.value =
                                const EdgeInsets.fromLTRB(0, 0, 0, 0);
                            // print(trendingSongList[index]
                            //     .videoIdForFetchStream
                            //     .toString());
                            fetchSongUriWeb(index);
                            currSongIndexListenable.value = index;
                          },
                          selected: MyClass.isSelected.value &&
                              index == MyClass.listIndex.value,
                          selectedTileColor: Colors.grey.shade200,
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
