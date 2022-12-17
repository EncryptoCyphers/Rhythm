import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_player_app/services/global.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '../pages/songs.dart';
import '../widgets/full_player.dart';
import '../pages/mini_player.dart';
import 'dart:io';
// https://pub.dev/packages/path_provider

ValueNotifier<int> loopOfSongNotifier =
    ValueNotifier<int>(0); // 0-> no loop, 1-> Same Song, 2-> all Songs
// ValueNotifier<Duration> triggerNextSongInLoopListenable =
//     ValueNotifier<Duration>(
//         const Duration(milliseconds: 0)); // 0-> no trigger, 1-> yes tgrigger

// final subscription = triggerNextSongInLoopListenable.listen((x, _) {
//   if (x > currSongDuration - const Duration(microseconds: 200) &&
//       loopOfSongNotifier.value == 2) {
//     print("djkwashduik");
//     skipToNext();
//   }
// });

var audioPlayer = AudioPlayer();
// bool of is Playing
bool isPlaying = false;
Duration songPosition = const Duration(seconds: 0);
Duration songDuration = const Duration(seconds: 1);
ValueNotifier<Duration> songPositionListenable =
    ValueNotifier<Duration>(const Duration(seconds: 0));
String currSongId = "0";
String currSongName = 'CurrSongName';
Duration currSongDuration = const Duration(seconds: 1);
String currSongArtistName = 'Artist Name';
String? currSongUri;
int currSongIndex = 0;
bool currSongIsWeb = false;
late VideoId? currSongVideoIdStremable;
late Uint8List defaultBG;
late Uint8List prevBG;
Uint8List currBG = Uint8List.fromList([]);
late final Directory tempDir;
// final File currBGFile = File('${tempDir.path}/images/currBG.png');
var currBGFile = 'file:///storage/emulated/0/Rhythm/currBG.jpg';
getCurrSongInfo({
  required String id,
  required name,
  required artist,
  required uri,
  required songIndex,
  required Duration duration,
  required bool isWeb,
  VideoId? streamId,
}) {
  currSongId = id;
  currSongName = name;
  currSongArtistName = artist;
  currSongUri = uri;
  currSongIndex = songIndex;
  currSongDuration = duration;
  currSongIsWeb = isWeb;
  currSongVideoIdStremable = streamId;
}

seekToDurationZero() {
  audioPlayer.seek(Duration.zero);
}

playSong(
    // {required AudioPlayer audioPlayer}
    ) async {
  currBGFile = 'hello';
  currBGFile = 'file:///storage/emulated/0/Rhythm/$currSongId.jpg';

  // print("Hello" + newDepricatedSongList[currSongIndex].filePath.toString());
  // print("Hello" + currBGFile.path.toString());
  // print("Hello " +
  //     Uri.parse("File:/" +
  //             newDepricatedSongList[currSongIndex].filePath.toString())
  //         .toString());
  // print("Hello " +
  //     Uri.parse(allSongsDevice[currSongIndex].uri.toString()).toString());
  // currSongIndexListenable.value = currSongIndex;
  // Define the playlist
  final playlist = ConcatenatingAudioSource(
    children: [
      // AudioSource.uri(Uri.parse(currSongUri!)),
      AudioSource.uri(
        Uri.parse(currSongUri!),

        //
        //
        /*----------------------------Notification----------------------------------------*/
        //
        tag: MediaItem(
          id: currSongId,
          title: currSongName,
          artist: currSongArtistName,
          duration: currSongDuration,
          // extras: {'LoadThumbnailUri': true},
          artUri: (currSongIsWeb)
              ? Uri.parse(
                  'https://img.youtube.com/vi/$currSongId/maxresdefault.jpg',
                )
              // : Uri.parse("File:/" +
              //     newDepricatedSongList[currSongIndex].filePath.toString()),
              // : Uri.parse(allSongsDevice[currSongIndex].uri.toString()),
              : Uri.parse('$currBGFile'),
        ),
      ),
      // AudioSource.uri(
      //     Uri.parse(allSongsDevice[currSongIndex + 1].uri.toString())),
      // AudioSource.uri(
      // Uri.parse(allSongsDevice[currSongIndex + 2].uri.toString())),
    ],
  );
  try {
    audioPlayer.setAudioSource(playlist, initialPosition: Duration.zero);
    // if (loopOfSongNotifier.value == 0 || loopOfSongNotifier.value == 2) {
    audioPlayer.setLoopMode(LoopMode.off);
    // } else if (loopOfSongNotifier.value == 1) {
    //   audioPlayer.setLoopMode(LoopMode.one);
    // }
    // audioPlayer.setLoopMode(LoopMode.one);
    audioPlayer.play();
    isPlaying = true;
  } on Exception {
    log("Error Parsing Song");
  }
  audioPlayer.durationStream.listen(
    (duration) {
      // setState(() {
      songDuration = currSongDuration + const Duration(milliseconds: 50);
      // });
    },
  );

  audioPlayer.positionStream.listen((currPosition) {
    songPositionListenable.value = currPosition;
    songPosition = currPosition;
  });
//     },
//   );
}

void skipToPrev() {
  if (currSongIndex > 0 &&
      currSongIndex < currSongList!.length &&
      currSongList!.length > 1) {
    // print(currSongIndex);

    currSongIndex--;
    getBG();
    currSongIndexListenable.value = currSongIndex;
    if (currSongIsWeb) {
      MyClass.listIndex.value = currSongIndex;
      fetchSongUriForCurrList(currSongIndex);
      // setState(() {
      //   currSongList![currSongIndex].title =
      //       currSongList![currSongIndex].title;
      // });
    } else {
      MyClass.localListIndex.value = currSongIndex;
      getCurrSongInfo(
        id: currSongList![currSongIndex].id.toString(),
        uri: currSongList![currSongIndex].uri,
        duration: currSongIsWeb
            ? (currSongList![currSongIndex].duration)
            : (Duration(milliseconds: currSongList![currSongIndex].duration)),
        isWeb: currSongList![currSongIndex].isWeb,
        name: currSongList![currSongIndex].title,
        artist: currSongList![currSongIndex].artist.toString(),
        songIndex: currSongIndex,
      );
      currSongIdListenable.value = currSongList![currSongIndex].id.toString();
      playSong(
          // audioPlayer: audioPlayer,
          );
    }
  }
}

Future skipToNext() async {
  if (currSongIndex >= 0 &&
      currSongIndex < currSongList!.length - 1 &&
      currSongList!.length > 1) {
    // print(currSongIndex);

    currSongIndex++;
    getBG();
    currSongIndexListenable.value = currSongIndex;
    if (currSongIsWeb) {
      MyClass.listIndex.value = currSongIndex;
      fetchSongUriForCurrList(currSongIndex);
      // setState(() {
      //   currSongList![currSongIndex].title =
      //       currSongList![currSongIndex].title;
      // });
    } else {
      MyClass.localListIndex.value = currSongIndex;
      getCurrSongInfo(
        id: currSongList![currSongIndex].id.toString(),
        uri: currSongList![currSongIndex].uri,
        duration: currSongIsWeb
            ? (currSongList![currSongIndex].duration)
            : (Duration(milliseconds: currSongList![currSongIndex].duration)),
        isWeb: currSongList![currSongIndex].isWeb,
        name: currSongList![currSongIndex].title,
        artist: currSongList![currSongIndex].artist.toString(),
        songIndex: currSongIndex,
      );
      currSongIdListenable.value = currSongList![currSongIndex].id.toString();
      playSong(
          // audioPlayer: audioPlayer,
          );
    }
  }
}

// Future<Uint8List> getCurrBG() async {
//   if (currSongIndex >= 0 && currSongIndex < currSongList!.length) {
//     currBG.clear();
//     // currBG = defaultBG;
//     currBG = await audioQuery.getArtwork(
//       size: const Size(550, 550),
//       type: ResourceType.SONG,
//       id: newDepricatedSongList[currSongIndex].id,
//     );
//     // if (currBG.isEmpty) {
//     //   currBG = defaultBG;
//     // }
//   }
//   return currBG;
// }

onLoopButtonPress() {
  (loopOfSongNotifier.value == 2)
      ? (loopOfSongNotifier.value = 0)
      : loopOfSongNotifier.value++;
}

getBG() async {
  //currBGListenable.value = true;
  currBG = Uint8List.fromList([]);
  currBG = await audioQuery.getArtwork(
    size: const Size(550, 550),
    type: ResourceType.SONG,
    id: newDepricatedSongList[currSongIndex].id,
  );

  File imgFile = File('storage/emulated/0/Rhythm/$currSongId.jpg');
  if (await imgFile.exists()) {
    if (currBG.isEmpty) {
      await imgFile.writeAsBytes(defaultBG);
    } else {
      await imgFile.writeAsBytes(currBG);
    }
  } else {
    imgFile.create();
    if (currBG.isEmpty) {
      await imgFile.writeAsBytes(defaultBG);
    } else {
      await imgFile.writeAsBytes(currBG);
    }
  }
  //currBGListenable.value = false;
}
