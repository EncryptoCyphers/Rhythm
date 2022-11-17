// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
// import 'package:music_player_app/pages/fetch_songs.dart';
import 'package:music_player_app/pages/home.dart';
import '../widgets/drawerMenu.dart';
import 'package:just_audio/just_audio.dart';
import '../widgets/bottomNavigationBar.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import './songs.dart';

class HomePage extends StatelessWidget {
  HomePage({required this.nm, required this.audioPlayer});
  String nm;
  final AudioPlayer audioPlayer;
  DateTime timeBackPressed = DateTime.now();

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        /*centerTitle: true,
        title: const Text("RYTHM"),*/
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: AnimSearchBar(
              prefixIcon: const Icon(
                Icons.search_rounded,
                color: Colors.black,
              ),
              width: 330,
              textController: textController,
              onSuffixTap: () {
                textController.clear();
              }, // Search function is to be implemented
              rtl: false,
              color: Colors.white,
              closeSearchOnSuffixTap: true,
              helpText: 'Search artists, songs...',
              suffixIcon: const Icon(
                Icons.close_rounded,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      drawer: DrawerMenu(
        audioPlayer: audioPlayer,
      ),
      bottomNavigationBar: const BottomNavBar(),
      backgroundColor: Colors.white,
      body: Home(
        nm: nm,
        audioPlayer: audioPlayer,
      ),
      // body: Tracks(
      //   audioPlayer: audioPlayer,
      // ),
    );
  }
}
/*return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= const Duration(seconds: 2);
        timeBackPressed = DateTime.now();
        if (isExitWarning) {
          const msgg = 'Press Back Again to exit';
          Fluttertoast.showToast(msg: msgg, fontSize: 18);
          return false;
        } else {
          Fluttertoast.cancel();
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.purpleAccent,
          centerTitle: true,
          title: const Text("RHYTHM"),
        ),
        bottomNavigationBar: const BottomNavBar(),
        drawer: const DrawerMenu(),
        // ignore: avoid_unnecessary_containers
        body: Column(
          children: [
            //Welcome Name//

            Container(
              alignment: Alignment.topCenter,
              child: Text(
                'Welcome $nm',
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ),

            //Dummy All Songs Button

            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Tracks(audioPlayer: audioPlayer)),
                );
              },
              child: const Text("All Songs "),
            )
          ],
        ),
      ),
    );*/
