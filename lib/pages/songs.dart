import 'package:flutter/material.dart';
import 'package:music_player_app/services/screen_sizes.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

//.............................Created Imports....................................................................//
import '../services/audioplayer.dart';
import '../services/mini_player.dart';
import '../services/player_logic.dart';

late List<SongModel> allSongs;
var dummy = bool;
//Gets Current time and Duration...........................................................................//

ValueNotifier<bool> storagePermissionListener = ValueNotifier<bool>(false);

class Tracks extends StatefulWidget {
  const Tracks({super.key});
  @override
  State<Tracks> createState() => _TracksState();
}

class _TracksState extends State<Tracks> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getStoragePermission();
    getAllSongList();
  }

  getAllSongList() async {
    allSongs = await _audioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
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
          if (allSongs.isEmpty) {
            return const Center(
              child: Text(
                'No Songs Found',
              ),
            );
          }
          // ignore: unnecessary_null_comparison
          if (allSongs == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: allSongs.length,
            itemBuilder: ((context, index) {
              // allSongs.clear();
              // allSongs.addAll(item.data);
              return Card(
                child: ListTile(
                  leading: QueryArtworkWidget(
                    id: allSongs[index].id,
                    type: ArtworkType.AUDIO,
                    nullArtworkWidget: const Icon(Icons.music_note),
                  ),
                  title: Text(
                    allSongs[index].displayNameWOExt,
                    maxLines: 2,
                  ),
                  subtitle: Text(allSongs[index].artist.toString()),
                  trailing: const Icon(Icons.more_horiz),
                  onTap: () {
                    isPlayingListenable.value = true;
                    miniPlayerVisibilityListenable.value = true;
                    currSongIdListenable.value = allSongs[index].id;
                    getCurrSongInfo(
                      id: allSongs[index].id,
                      uri: allSongs[index].uri,
                      name: allSongs[index].displayNameWOExt,
                      artist: allSongs[index].artist.toString(),
                      songIndex: index,
                    );
                    playSong(audioPlayer: audioPlayer);
                  },
                ),
              );
            }),
          );
        }
      },
    );
  }
}
