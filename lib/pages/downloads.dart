import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_player_app/services/colours.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_audio_query/flutter_audio_query.dart';

final FlutterAudioQuery audioQuery = FlutterAudioQuery();
List<SongInfo> newList = [];
getSongs() async {
  newList = await audioQuery.getSongs();
  for (SongInfo i in newList) {
    debugPrint(i.title);
  }
}

class Downloads extends StatefulWidget {
  const Downloads({Key? key}) : super(key: key);

  @override
  State<Downloads> createState() => _DownloadsState();
}

class _DownloadsState extends State<Downloads> {
  @override
  void initState() {
    super.initState();
    getSongs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Downloads'),
          backgroundColor: fgPurple,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: FutureBuilder<Uint8List>(
            future: audioQuery.getArtwork(
                size: const Size(550, 550),
                type: ResourceType.SONG,
                id: newList[11].id),
            builder: (_, snapshot) {
              if (snapshot.data == null) {
                debugPrint(newList[12].id.toString());
                return const SizedBox(
                  height: 250.0,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              return Image.memory(snapshot.data!);
            })
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     const SizedBox(
        //       width: double.infinity,
        //     ),
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         const Icon(
        //           FontAwesomeIcons.solidFaceFrown,
        //           size: 80,
        //           color: Color.fromARGB(255, 116, 92, 201),
        //         ),
        //         const SizedBox(
        //           width: 20,
        //         ),
        //         Column(
        //           children: [
        //             Text(
        //               'ERROR',
        //               style: TextStyle(
        //                 fontSize: 35,
        //                 fontWeight: FontWeight.bold,
        //                 color: fgPurple,
        //               ),
        //             ),
        //             Text(
        //               'Service Unavailable',
        //               style: TextStyle(
        //                 fontSize: 17.5,
        //                 color: fgPurple,
        //               ),
        //             )
        //           ],
        //         )
        //       ],
        //     )
        //   ],
        // )
        );
  }
}
