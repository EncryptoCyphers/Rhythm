import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:google_fonts/google_fonts.dart';

class Youtube extends StatelessWidget {
  const Youtube({super.key});

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
    return Column(
      children: [
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
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: GFCarousel(
            items: imageList.map(
              (url) {
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    child: Image.network(url, fit: BoxFit.cover, width: 1000.0),
                  ),
                );
              },
            ).toList(),
            onPageChanged: (index) {
              //Your Code Here
            },
            autoPlay: true,
            hasPagination: true,
            pagerSize: 10,
            enlargeMainPage: true,
            activeIndicator: Colors.deepPurple,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: ListView.builder(
            itemCount: imageList.length,
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
      ],
    );
  }
}
