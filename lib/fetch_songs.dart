import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

//.............................Created Imports....................................................................//
import './audioplayer.dart';

class Tracks extends StatefulWidget {
  const Tracks({Key? key, required this.audioPlayer}) : super(key: key);
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

  void requestPermission() {
    Permission.storage.request();
  }

  //final  _audioPlayer = widget.audioPlayer;
  final _audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('All Songs'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: FutureBuilder<List<SongModel>>(
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
              child: (Text(
                'No Songs Found',
              )),
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
                      getaudiobannerindex(
                          index: item.data![index].id,
                          uri: item.data![index].uri);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Player(
                            songmodel: item.data![index],
                            audioPlayer: widget.audioPlayer,
                          ),
                        ),
                      );
                    },
                  ),
                )),
            itemCount: item.data!.length,
          );
        },
      ),
    );
  }
}
