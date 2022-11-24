import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:music_player_app/pages/home_page.dart';
import 'package:music_player_app/pages/onboarding_screen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // isDrawerOpen.value = false;
            return HomePage(
              nm: user!.email.toString().split('@')[0],
            );
          } else {
            return const OnboardingPage();
          }
        },
      ),
    );
  }
}
