import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player_app/pages/full_player.dart';
import 'package:music_player_app/pages/mini_player.dart';
import 'package:music_player_app/services/trending_songs.dart';
import 'package:youtube/youtube_thumbnail.dart';

import '../services/get_yt_searches.dart';
import '../services/player_logic.dart';

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
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
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
                      return GestureDetector(
                          onTap: () {},
                          child: Image.network(
                            YoutubeThumbnail(youtubeId: trendingSong.id).mq(),
                          ));
                    }).toList(),
                  );
                }),
          ),

          /*-----------------------------------Text Box-----------------------------------*/
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
            child: Text(
              'Recent Searches',
              style: GoogleFonts.laila(
                color: Colors.deepPurple,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          /*-----------------------------------Recent Searches-----------------------------------*/
          FutureBuilder(
            future: makeTrendingSongList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Text(
                  'Something went wrrong!!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                );
              }
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: ListView.builder(
                  itemCount: trendingSongList.length,
                  itemBuilder: (context, index) {
                    return GFListTile(
                      avatar: Image(
                        image: NetworkImage(
                            YoutubeThumbnail(youtubeId: imageList[index]).mq()),
                        width: 90,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      titleText: trendingSongList[index].title,
                      subTitleText: trendingSongList[index].artist,
                      icon: const FaIcon(
                        FontAwesomeIcons.youtube,
                        color: Colors.red,
                      ),
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
