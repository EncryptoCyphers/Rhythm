import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/transparent_image_card.dart';

class Youtube extends StatefulWidget {
  const Youtube({super.key});

  @override
  State<Youtube> createState() => _YoutubeState();
}

final List<String> imageList = [
  "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg",
  "https://cdn.pixabay.com/photo/2017/12/13/00/23/christmas-3015776_960_720.jpg",
  "https://cdn.pixabay.com/photo/2019/12/19/10/55/christmas-market-4705877_960_720.jpg",
  "https://cdn.pixabay.com/photo/2019/12/20/00/03/road-4707345_960_720.jpg",
  "https://cdn.pixabay.com/photo/2019/12/22/04/18/x-mas-4711785__340.jpg",
  "https://cdn.pixabay.com/photo/2016/11/22/07/09/spruce-1848543__340.jpg"
];

class _YoutubeState extends State<Youtube> {
  @override
  Widget build(BuildContext context) {
    return ListView(
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
        GFCarousel(
          items: imageList.map(
            (url) {
              return Container(
                margin: const EdgeInsets.all(25.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                    width: 1000.0,
                  ),
                ),
              );
            },
          ).toList(),
          onPageChanged: (index) {
            setState(() {
              index;
            });
          },
          autoPlay: true,
          hasPagination: true,
          pagerSize: 10,
          enlargeMainPage: true,
          activeIndicator: Colors.deepPurple,
        ),
        const SizedBox(
          height: 10,
        ),
        GFListTile(
          avatar: Image(
            image: NetworkImage(imageList[4]),
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
        ),
        GFListTile(
          avatar: Image(
            image: NetworkImage(imageList[0]),
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
        ),
        GFListTile(
          avatar: Image(
            image: NetworkImage(imageList[1]),
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
        ),
        GFListTile(
          avatar: Image(
            image: NetworkImage(imageList[2]),
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
        ),
        GFListTile(
          avatar: Image(
            image: NetworkImage(imageList[3]),
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
        ),
      ],
    );
  }
}
