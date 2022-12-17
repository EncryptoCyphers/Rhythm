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
import 'dart:io';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_player_app/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:permission_handler/permission_handler.dart';
import './firebase_options.dart';
// import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  // var appDir = await getApplicationSupportDirectory();
  // var appDirPath = appDir.path;
  // Directory newDir = Directory('$appDirPath/Rhythm');
  // print('Hello $appDirPath');
  // await newDir.create(recursive: true);
  // tempDir = await getTemporaryDirectory();
  // const folderName = 'Rhythm';
  final path = Directory("storage/emulated/0/Rhythm");
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }
  if ((await path.exists())) {
    // if (await File('$path/CurrBG.png').exists()) {
    // } else {
    //   File('$path/CurrBG.png').create();
    // }
    // return path.path;
  } else {
    path.create(recursive: true);
    // return path.path;
  }
//   // tempDir = await getLibraryDirectory();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // audioPlayer is declared in main.dart ...............................//
    // reason: Only one Instance of AudioPlayer is needed. So It must be declared in main.dart
    //        and passed through Constructors................//
    // Else: Multiple Instances of a player may get created and multiple files may start playing Simultaniously//

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue, textTheme: GoogleFonts.lailaTextTheme()),
      home: AnimatedSplashScreen(
        splash: Image.asset('images/app_icon.jpg'),
        duration: 100,
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.white,
        // nextScreen: OnboardingPage(
        //   audioPlayer: audioPlayer,
        // ),
        nextScreen: const Login(),
      ),
    );
  }
}
