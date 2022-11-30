import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:music_player_app/pages/home.dart';
import 'package:music_player_app/pages/settings.dart';
import 'package:music_player_app/pages/songs.dart';
import 'package:music_player_app/pages/web.dart';

import '../widgets/b_nav.dart';

class Pages extends StatefulWidget {
  const Pages({super.key, required this.nm, required this.pageController});
  final String nm;
  final PageController pageController;

  @override
  State<Pages> createState() => _PagesState();
}

//Function to get the username from the firestore database
var username = "";
String getData(String email) {
  FirebaseFirestore.instance
      .collection('Rhythm_Users')
      .doc(email)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      username = documentSnapshot.get("username").toString();
    } else {
      username = email.split('@')[0];
    }
  });
  print(username);
  return username;
}

class _PagesState extends State<Pages> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: PageView(
        onPageChanged: (index) {
          navIndexListener.value = index;
        },
        controller: widget.pageController,
        children: [
          Home(
            nm: getData(FirebaseAuth.instance.currentUser!.email.toString()),
          ),
          const WebPage(),
          const Tracks(),
          const SettingsPage(),
        ],
      ),
    );
  }
}
