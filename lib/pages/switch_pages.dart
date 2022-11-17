import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player_app/pages/home.dart';
import 'package:music_player_app/pages/songs.dart';
import 'package:music_player_app/widgets/bottomNavigationBar.dart';
// import 'package:music_player_app/widgets/bottomNavigationBar.dart';

class Pages extends StatelessWidget {
  const Pages({super.key, required this.nm, required this.audioPlayer});
  final String nm;
  final AudioPlayer audioPlayer;

  static ValueNotifier<int> currPageIndex = ValueNotifier<int>(0);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ValueListenableBuilder<int>(
      builder: (BuildContext context, int value, Widget? child) {
        if (pageIndex == 2) {
          return Tracks(
            audioPlayer: audioPlayer,
          );
        }
        // else if ((value == 1)) {
        //   return ;
        // }
        // else if ((value == 3)) {
        //   return ;
        // }
        else {
          return Home(
            nm: nm,
            audioPlayer: audioPlayer,
          );
        }
      },
      valueListenable: currPageIndex,
    ));
  }
}

// class Pages extends StatefulWidget {
//   const Pages(
//       {super.key,
//       // required this.currPageIndex,
//       required this.nm,
//       required this.audioPlayer});
//   // final int currPageIndex;
//   final String nm;
//   final AudioPlayer audioPlayer;
//   @override
//   State<Pages> createState() => _PagesState();
// }

// class _PagesState extends State<Pages> {
//   // int index = widget.currPageIndex;
//   static ValueNotifier<int> currPageIndex = ValueNotifier<int>();
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//         child: ValueListenableBuilder<int>(
//       builder: (BuildContext context, int value, Widget? child) {
//         if (value == 2) {
//           return Tracks(
//             audioPlayer: widget.audioPlayer,
//           );
//         }
//         // else if ((widget.currPageIndex == 1)) {
//         //   return ;
//         // }
//         // else if ((widget.currPageIndex == 3)) {
//         //   return ;
//         // }
//         else {
//           return Home(
//             nm: widget.nm,
//             audioPlayer: widget.audioPlayer,
//           );
//         }
//       },
//       valueListenable: currPageIndex1,
//     ));
//   }
// }
