import 'package:flutter/material.dart';
import 'package:music_player_app/services/colours.dart';
// ignore: import_of_legacy_library_into_null_safe
// import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Downloads extends StatefulWidget {
  const Downloads({Key? key}) : super(key: key);

  @override
  State<Downloads> createState() => _DownloadsState();
}

class _DownloadsState extends State<Downloads> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: fgPurple,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: (() {
            Navigator.pop(context);
          }),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: double.infinity,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                FontAwesomeIcons.solidFaceFrown,
                size: 80,
                color: Color.fromARGB(255, 116, 92, 201),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  Text(
                    'ERROR',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: fgPurple,
                    ),
                  ),
                  Text(
                    'Service Unavailable',
                    style: TextStyle(
                      fontSize: 17.5,
                      color: fgPurple,
                    ),
                  )
                ],
              )
            ],
          )
        ],
        // )
      ),
    );
  }
}
