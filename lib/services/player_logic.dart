import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';

AudioPlayer audioPlayer = AudioPlayer();
// bool of is Playing
bool isPlaying = false;
Duration songDuration = const Duration();
Duration songPosition = const Duration();
ValueNotifier<Duration> songPositionListenable =
    ValueNotifier<Duration>(const Duration());
int currSongId = 0;
String currSongName = 'CurrSongName';
String currSongArtistName = 'Artist Name';
String? currSongUri;
int currSongIndex = 0;
getCurrSongInfo(
    {required id,
    required name,
    required artist,
    required uri,
    required songIndex}) {
  currSongId = id;
  currSongName = name;
  currSongArtistName = artist;
  currSongUri = uri;
  currSongIndex = songIndex;
}

String prevSongName = 'PrevSongName';
String prevSongArtistName = 'Prev Song Artist Name';
String? prevSongUri;
getPrevSongInfo({required name, required artist, required uri}) {
  currSongName = name;
  currSongArtistName = artist;
  currSongUri = uri;
}

String nextSongName = 'NextSongName';
String nextSongArtistName = 'Next Song Artist Name';
String? nextSongUri;
getNextSongInfo({required name, required artist, required uri}) {
  nextSongName = name;
  nextSongArtistName = artist;
  nextSongUri = uri;
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
      songDuration = duration!;
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
