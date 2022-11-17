import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player_app/pages/home_page.dart';
import 'package:music_player_app/pages/onboarding_screen.dart';

class Login extends StatefulWidget {
  final AudioPlayer audioPlayer;
  const Login({super.key, required this.audioPlayer});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage(
              audioPlayer: widget.audioPlayer,
              nm: 'It\'s Rhythm time',
            );
          } else {
            return OnboardingPage(
              audioPlayer: widget.audioPlayer,
            );
          }
        },
      ),
    );
  }
}
