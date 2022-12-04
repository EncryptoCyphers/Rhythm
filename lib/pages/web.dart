import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player_app/services/trending_songs.dart';
import 'package:youtube/youtube_thumbnail.dart';

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

  Future<void> makeTrendingSongList() async {
    //await Future.delayed(const Duration(seconds: 2));
    await trending.getTrendingMusic();
  }

  @override
  Widget build(BuildContext context) {
    //Dummy Image Fetch List
    final List<String> imageList = [
      "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg",
      "https://cdn.pixabay.com/photo/2017/12/13/00/23/christmas-3015776_960_720.jpg",
      "https://cdn.pixabay.com/photo/2019/12/19/10/55/christmas-market-4705877_960_720.jpg",
      "https://cdn.pixabay.com/photo/2019/12/20/00/03/road-4707345_960_720.jpg",
      "https://cdn.pixabay.com/photo/2019/12/22/04/18/x-mas-4711785__340.jpg",
      "https://cdn.pixabay.com/photo/2016/11/22/07/09/spruce-1848543__340.jpg"
    ];
    return SingleChildScrollView(
      child: Column(
        children: [
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: FutureBuilder(
                future: makeTrendingSongList(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.connectionState == ConnectionState.done ||
                      snapshot.connectionState == ConnectionState.active) {
                    return CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: true,
                      ),
                      items: trendingSongList.map((trendingSong) {
                        return Image.network(
                            YoutubeThumbnail(youtubeId: trendingSong.id).mq());
                      }).toList(),
                    );
                  } else {
                    return const Text('Trending Songs cannot be fetched');
                  }
                }),
          ),
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
          /*
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: ListView.builder(
              itemCount: trendingSongList.length,
              itemBuilder: (context, index) {
                return GFListTile(
                  avatar: Image(
                    image: NetworkImage(imageList[index]),
                    width: 90,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  titleText: 'Song Name',
                  subTitleText: 'Artist Name or Channel name if required',
                  icon: const FaIcon(
                    FontAwesomeIcons.youtube,
                    color: Colors.red,
                  ),
                );
              },
            ),
          ),
          */
        ],
      ),
    );
  }
}
