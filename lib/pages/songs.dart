import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player_app/services/screen_sizes.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

//.............................Created Imports....................................................................//
import '../services/audioplayer.dart';
import '../services/mini_player.dart';

var dummy = bool;
//Gets Current time and Duration...........................................................................//

ValueNotifier<Duration> songPositionListenable =
    ValueNotifier<Duration>(const Duration());
ValueNotifier<bool> storagePermissionListener = ValueNotifier<bool>(false);

Duration songDuration = const Duration();
Duration songPosition = const Duration();

class Tracks extends StatefulWidget {
  const Tracks({super.key, required this.audioPlayer});
  final AudioPlayer audioPlayer;
  @override
  State<Tracks> createState() => _TracksState();
}

class _TracksState extends State<Tracks> {
  playSong() {
    try {
      widget.audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(audioUri!)));
      widget.audioPlayer.play();
      isPlaying = true;
    } on Exception {
      log("Error Parsing Song");
    }
    widget.audioPlayer.durationStream.listen(
      (duration) {
        // setState(() {
        songDuration = duration!;
        // });
      },
    );
    widget.audioPlayer.positionStream.listen(
      (currPosition) {
        // setState(() {
        songPositionListenable.value = currPosition;
        songPosition = currPosition;
        // });
      },
    );
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getStoragePermission();
  }

  Future getStoragePermission() async {
    if (await Permission.storage.request().isGranted) {
      storagePermissionListener.value = true;
    } else if (await Permission.storage.request().isPermanentlyDenied) {
      await openAppSettings();
      if (await Permission.storage.request().isGranted) {
        storagePermissionListener.value = true;
      }
    }
  }

  //final  _audioPlayer = widget.audioPlayer;
  final _audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: storagePermissionListener,
      builder: (BuildContext context, bool permission, Widget? child) {
        if (storagePermissionListener.value == false) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Storage Permission is Denied'),
              SizedBox(
                height: logicalHeight * 0.03,
              ),
              const Text('Provide Storage Permission'),
              const Text(
                '↓',
                textScaleFactor: 1.5,
              ),
              SizedBox(
                height: logicalHeight * 0.02,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.all(12),
                  animationDuration: const Duration(seconds: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  shadowColor: Colors.redAccent,
                ),
                onPressed: getStoragePermission,
                child: const Text('Grant Permission'),
              )
            ],
          );
        } else {
          return FutureBuilder<List<SongModel>>(
            future: _audioQuery.querySongs(
              sortType: null,
              orderType: OrderType.ASC_OR_SMALLER,
              uriType: UriType.EXTERNAL,
              ignoreCase: true,
            ),
            builder: (context, item) {
              if (item.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (item.data!.isEmpty) {
                return const Center(
                  child: Text(
                    'No Songs Found',
                  ),
                );
              }
              return ListView.builder(
                itemBuilder: ((context, index) => Card(
                      child: ListTile(
                        leading: QueryArtworkWidget(
                          id: item.data![index].id,
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: const Icon(Icons.music_note),
                        ),
                        title: Text(
                          item.data![index].displayNameWOExt,
                          maxLines: 2,
                        ),
                        subtitle: Text(item.data![index].artist.toString()),
                        trailing: const Icon(Icons.more_horiz),
                        onTap: () {
                          isPlayingListenable.value = true;
                          miniPlayerVisibilityListenable.value = true;
                          miniaudiobannerIndex.value = item.data![index].id;
                          getSongInfo(
                            uri: item.data![index].uri,
                            name: item.data![index].displayNameWOExt,
                            artist: item.data![index].artist.toString(),
                          );
                          getaudiobannerindex(
                            index: item.data![index].id,
                            uri: item.data![index].uri,
                          );
                          model = item.data![index];
                          playSong();

                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => Player(
                          //       songmodel: item.data![index],
                          //       audioPlayer: widget.audioPlayer,
                          //     ),
                          //   ),
                          // );
                        },
                      ),
                    )),
                itemCount: item.data!.length,
              );
            },
          );
        }
        //fute
      },
    );
  }
}
