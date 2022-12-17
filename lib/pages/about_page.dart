/*
 *  This file is part of Rhythm (https://github.com/EncryptoCyphers/Rhythm).
 * 
 * Rhythm is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Rhythm is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with Rhythm.  If not, see <http://www.gnu.org/licenses/>.
 * 
 * Copyright (c) 2022-2023, EncryptoCyphers
 */
import 'package:flutter/material.dart';
import 'package:music_player_app/services/colours.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse('https://www.linkedin.com/in/ankit-paul-914936234/');
final Uri _url2 = Uri.parse('https://www.linkedin.com/in/arpan-de-001ab31b9/');
final Uri _url3 = Uri.parse('https://www.linkedin.com/in/arnab7070/');
final Uri _url4 =
    Uri.parse('https://www.linkedin.com/in/bishal-karmakar-2a234623a/');
final Uri _url5 = Uri.parse('https://github.com/EncryptoCyphers/Rhythm');

class AppInfo extends StatelessWidget {
  const AppInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: fgPurple,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
          ),
          Image.asset('images/app_icon.jpg', height: 150),
          const Text(
            'RHYTHM Music & MP3 Player',
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22.5,
              color: Colors.deepPurple,
            ),
          ),
          const Text(
            'v1.0.0',
            style: TextStyle(fontSize: 20, color: Colors.deepPurple),
          ),
          Container(
            height: 40,
          ),
          const Text(
            'This is an open source project and can be found on',
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                iconSize: 50,
                onPressed: _launchUrl5,
                icon: Image.asset('images/github.png'),
              ),
              const TextButton(
                onPressed: _launchUrl5,
                child: Text(
                  'GitHub',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
            ],
          ),
          const Text(
            'If you liked our work',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          const Text(
            'show some ❤ and ⭐ the repository',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          /*
          const Text(
            'and rate us on',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  LaunchReview.launch(androidAppId: "com.android.chrome");
                },
                icon: Image.asset('images/google_play.png'),
                iconSize: 50,
              ),
              TextButton(
                onPressed: () {
                  LaunchReview.launch(androidAppId: "com.android.chrome");
                },
                child: const Text(
                  'Download & Install Now',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              )
            ],
          ),
          */
          Container(
            height: 40,
          ),
          const Text(
            'Made with ❤ by',
            style: TextStyle(
              color: Colors.deepPurple,
              fontSize: 17.5,
            ),
          ),
          /*
          const SizedBox(
            //height: 30,
            child: TextButton(
              onPressed: _launchUrl3,
              child: Text(
                'Arnab Nandi',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),
          const SizedBox(
            //height: 30,
            child: TextButton(
              onPressed: _launchUrl4,
              child: Text(
                'Bishal Karmakar',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),
          const SizedBox(
            //height: 30,
            child: TextButton(
              onPressed: _launchUrl,
              child: Text(
                'Ankit Paul',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),
          const SizedBox(
            //height: 30,
            child: TextButton(
              onPressed: _launchUrl2,
              child: Text(
                'Arpan De',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),
          */
          GestureDetector(
            onTap: _launchUrl4,
            child: const Text(
              'Bishal Karmakar',
              style: TextStyle(
                fontSize: 15,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: _launchUrl3,
            child: const Text(
              'Arnab Nandi',
              style: TextStyle(
                fontSize: 15,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: _launchUrl,
            child: const Text(
              'Ankit Paul',
              style: TextStyle(
                fontSize: 15,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          /*
          GestureDetector(
            onTap: _launchUrl2,
            child: const Text(
              'Arpan De',
              style: TextStyle(
                fontSize: 15,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          */
        ],
      ),
    );
  }
}

Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
}

// ignore: unused_element
Future<void> _launchUrl2() async {
  if (!await launchUrl(_url2)) {
    throw 'Could not launch $_url2';
  }
}

Future<void> _launchUrl3() async {
  if (!await launchUrl(_url3)) {
    throw 'Could not launch $_url3';
  }
}

Future<void> _launchUrl4() async {
  if (!await launchUrl(_url4)) {
    throw 'Could not launch $_url4';
  }
}

Future<void> _launchUrl5() async {
  if (!await launchUrl(_url5)) {
    throw 'Could not launch $_url5';
  }
}
