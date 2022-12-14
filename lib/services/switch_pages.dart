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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
  //print(username);
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
        children: const [
          // Home(
          //   nm: FirebaseAuth.instance.currentUser!.email
          //       .toString()
          //       .split('@')[0],
          // ),
          Youtube(),
          Tracks(),
          SettingsPage(),
        ],
      ),
    );
  }
}
