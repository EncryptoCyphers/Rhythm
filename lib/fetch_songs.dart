import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

import './audioplayer.dart';

class Tracks extends StatefulWidget {
  const Tracks({Key? key}) : super(key: key);

  @override
  State<Tracks> createState() => _TracksState();
}

class _TracksState extends State<Tracks> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestPermission();
  }

  void requestPermission() {
    Permission.storage.request();
  }

  final _audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('All Songs'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
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
                      leading: const Icon(Icons.music_note),
                      title: Text(item.data![index].displayNameWOExt),
                      subtitle: Text(item.data![index].artist.toString()),
                      trailing: const Icon(Icons.more_horiz),
                      onTap: () {
                        //playSong(item.data![index].uri);
                      },
                    ),
                  )),
              itemCount: item.data!.length,
            );
          }),
    );
  }
}
