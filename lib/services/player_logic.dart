import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player_app/services/global.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../widgets/full_player.dart';
import '../pages/mini_player.dart';

AudioPlayer audioPlayer = AudioPlayer();
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

playSong({required AudioPlayer audioPlayer}) {
  try {
    audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(currSongUri!)));
    audioPlayer.play();
    isPlaying = true;
  } on Exception {
    log("Error Parsing Song");
  }
  audioPlayer.durationStream.listen(
    (duration) {
      // setState(() {
      songDuration = currSongDuration;
      // });
    },
  );
  audioPlayer.positionStream.listen(
    (currPosition) {
      // setState(() {
      songPositionListenable.value = currPosition;
      songPosition = currPosition;
      // });
    },
  );
}

void skipToPrev() {
  if (currSongIndex >= 0 &&
      currSongIndex < currSongList!.length &&
      currSongList!.length > 1) {
    // print(currSongIndex);

    currSongIndex--;
    MyClass.listIndex.value = currSongIndex;
    if (currSongIsWeb) {
      currSongIndexListenable.value = currSongIndex;
      fetchSongUriForCurrList(currSongIndex);
      // setState(() {
      //   currSongList![currSongIndex].title =
      //       currSongList![currSongIndex].title;
      // });
    } else {
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
      playSong(audioPlayer: audioPlayer);
    }
  }
}

void skipToNext() {
  if (currSongIndex >= 0 &&
      currSongIndex < currSongList!.length &&
      currSongList!.length > 1) {
    // print(currSongIndex);

    currSongIndex++;
    MyClass.listIndex.value = currSongIndex;
    if (currSongIsWeb) {
      currSongIndexListenable.value = currSongIndex;
      fetchSongUriForCurrList(currSongIndex);
      // setState(() {
      //   currSongList![currSongIndex].title =
      //       currSongList![currSongIndex].title;
      // });
    } else {
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
      playSong(audioPlayer: audioPlayer);
    }
  }
}
