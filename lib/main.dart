import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_player_app/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import './firebase_options.dart';
// import 'firebase_options.dart';
import 'package:path_provider/path_provider.dart';
import './services/player_logic.dart';

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
  tempDir = await getTemporaryDirectory();
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
