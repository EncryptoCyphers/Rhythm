import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

//.............................Created Imports....................................................................//
import '../services/audioplayer.dart';
import '../services/mini_player.dart';

var dummy = bool;

class Tracks extends StatefulWidget {
  const Tracks({super.key, required this.audioPlayer});
  final AudioPlayer audioPlayer;
  @override
  State<Tracks> createState() => _TracksState();
}

class _TracksState extends State<Tracks> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    requestPermission();
  }

  //final  _audioPlayer = widget.audioPlayer;
  final _audioQuery = OnAudioQuery();

  void requestPermission() {
    Permission.storage.request();
  }

  @override
  Widget build(BuildContext context) {
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
                  title: Text(item.data![index].displayNameWOExt),
                  subtitle: Text(item.data![index].artist.toString()),
                  trailing: const Icon(Icons.more_horiz),
                  onTap: () {
                    isPlayingValueListenable.value = true;
                    miniaudiobannerIndex.value = item.data![index].id;
                    getSongInfo(
                      name: item.data![index].displayNameWOExt,
                      artist: item.data![index].artist.toString(),
                    );
                    getaudiobannerindex(
                      index: item.data![index].id,
                      uri: item.data![index].uri,
                    );
                    model = item.data![index];
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
}
