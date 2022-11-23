import 'package:flutter/material.dart';
import 'package:music_player_app/pages/home.dart';
import 'package:music_player_app/pages/settings.dart';
import 'package:music_player_app/pages/songs.dart';
import 'package:music_player_app/pages/web.dart';

import '../widgets/b_nav.dart';

var pageController = PageController(initialPage: 0);

class Pages extends StatelessWidget {
  const Pages({super.key, required this.nm});
  final String nm;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PageView(
        onPageChanged: (index) {
          navIndexListener.value = index;
        },
        controller: pageController,
        children: [
          Home(
            nm: nm,
          ),
          const WebPage(),
          const Tracks(),
          const Settings()
        ],
      ),
    );
  }
}
