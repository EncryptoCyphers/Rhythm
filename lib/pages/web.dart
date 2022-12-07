import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
//import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_player_app/pages/songs.dart';
import 'package:music_player_app/services/colours.dart';
// import 'package:music_player_app/pages/full_player.dart';
// import 'package:music_player_app/pages/mini_player.dart';
import 'package:music_player_app/services/trending_songs.dart';
import 'package:youtube/youtube_thumbnail.dart';

// import '../services/get_yt_searches.dart';
// import '../services/player_logic.dart';

// ignore: must_be_immutable
class Youtube extends StatefulWidget {
  const Youtube({super.key});

  @override
  State<Youtube> createState() => _YoutubeState();
}

class _YoutubeState extends State<Youtube> {
  Trending trending = Trending();

  /*
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    trending.getTrendingMusic();
    print(trendingSongList[0].title);
  }
  */
  int _selectedIndex = 0;
  final listIndex = ValueNotifier<int>(0);
  final List<String> imageList = [];
  Future<void> makeTrendingSongList() async {
    //await Future.delayed(const Duration(seconds: 2));
    await trending.getTrendingMusic();
    for (int i = 0; i < trendingSongList.length; i++) {
      imageList.add(trendingSongList[i].id);
    }
    // print(imageList);
  }

  void listTileColorChange(int index) {
    listIndex.value = index;
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
                            child: Center(
                              child: LoadingAnimationWidget.dotsTriangle(
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
                        return CarouselSlider(
                          options: CarouselOptions(
                            autoPlay: true,
                            enlargeCenterPage: true,
                          ),
                          items: trendingSongList.map((trendingSong) {
                            int index = trendingSongList.indexOf(trendingSong);
                            return GestureDetector(
                              onTap: () {
                                print(index);
                              },
                              child: Image.network(
                                YoutubeThumbnail(youtubeId: trendingSong.id)
                                    .mq(),
                              ),
                            );
                          }).toList(),
                        );
                      }),
                ),

                /*-----------------------------------Text Box-----------------------------------*/
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                  child: Text(
                    'Unknown Category',
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

          /*-----------------------------------Recent Searches-----------------------------------*/
          FutureBuilder(
            future: makeTrendingSongList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: LoadingAnimationWidget.inkDrop(
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
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.45,
                child: ValueListenableBuilder(
                  valueListenable: listIndex,
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
                          trailing: Text(
                            trendingSongList[index]
                                .duration
                                .toString()
                                .substring(3, 7),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: fgPurple,
                            ),
                          ),
                          onTap: () {
                            listTileColorChange(index);
                          },
                          selected: index == listIndex.value,
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
