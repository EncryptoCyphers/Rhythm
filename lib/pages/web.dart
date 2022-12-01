import 'package:flutter/material.dart';
// import 'package:music_player_app/pages/songs.dart';
// import 'package:music_player_app/services/data_service_and_song_query.dart';
// import 'package:youtube/youtube_thumbnail.dart';

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
    return const Center(
      child: Text('Dummy Yt Page'),
    );
  }
}
