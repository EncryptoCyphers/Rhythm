// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player_app/pages/onboarding_screen.dart';
import 'package:music_player_app/services/colours.dart';
import 'package:music_player_app/services/screen_sizes.dart';
// import 'package:music_player_app/widgets/bottomNavigationBar.dart';
import '../pages/about_page.dart';
import '../pages/settings.dart';
import '../pages/downloads.dart';
import '../pages/playlist.dart';
import '../pages/switch_pages.dart';
import '../widgets/b_nav.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key, required this.audioPlayer}) : super(key: key);
  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    final userEmail = FirebaseAuth.instance.currentUser!.email;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Drawer(
          width: logicalWidth * 0.7,
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.pink,
                      Colors.deepPurple.shade600,
                      Colors.deepPurple.shade600,
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Material(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      child: Image.asset(
                        //Later it will be implemented with user image using firebase storage.
                        'images/app_icon.jpg',
                        height: 100,
                        width: 100,
                      ),
                    ),
                    Text(
                      'Email: $userEmail',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.home,
                  color: Colors.deepPurple,
                ),
                title: const Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  navIndexListener.value = 0; //To build navbar
                  Pages.currPageIndex.value = 0;
                  Navigator.pop(context); //to pop out the drawer instantly
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.storage,
                  color: Colors.deepPurple,
                ),
                title: const Text(
                  'Local Music',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  navIndexListener.value = 2; //To build navbar
                  Pages.currPageIndex.value = 2; //To build pages
                  Navigator.pop(context); //to pop out the drawer instantly
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.download,
                  color: Colors.deepPurple,
                ),
                title: const Text(
                  'Downloads',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Downloads()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.playlist_play_rounded,
                  color: Colors.deepPurple,
                ),
                title: const Text(
                  'Playlist',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Playlist()));
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.settings,
                  color: Colors.deepPurple,
                ),
                title: const Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Settings()));
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.info_outline,
                  color: Colors.deepPurple,
                ),
                title: const Text(
                  'About',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const AppInfo()));
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.logout_rounded,
                  color: Colors.deepPurple,
                ),
                title: const Text(
                  'Log Out',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () async {
                  //Firebase logout implementation will be done

                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      title: const Text(
                        'Log Out',
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      content: const Text(
                        'Are you sure ?',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();

                            FirebaseAuth.instance
                                .authStateChanges()
                                .listen((User? user) {
                              if (user == null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OnboardingPage(
                                      audioPlayer: audioPlayer,
                                    ),
                                  ),
                                );
                              } else {
                                // print('User is signed in!');
                              }
                            });
                          },
                          child: const Text(
                            'Log Out',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
