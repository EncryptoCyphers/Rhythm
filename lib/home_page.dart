// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import './drawerMenu.dart';
import './fetch_songs.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatelessWidget {
  String nm;

  HomePage({required this.nm});
  DateTime timeBackPressed = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference>=Duration(seconds: 2);
        timeBackPressed = DateTime.now();
        if (isExitWarning) {
          final msgg = 'Press Back Again to exit';
          Fluttertoast.showToast(msg: msgg, fontSize: 18);
          return false;
        }
        else {
          Fluttertoast.cancel();
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.purpleAccent,
          centerTitle: true,
          title: const Text("RYTHM"),
        ),
        drawer: const DrawerMenu(),
        // ignore: avoid_unnecessary_containers
        body: Column(
          children: [
            //Welcome Name//

            Container(
              alignment: Alignment.topCenter,
              child: Text(
                'Welcome $nm',
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ),

            //Dummy All Songs Button

            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Tracks()),
                );
              },
              child: const Text("All Songs "),
            )
          ],
        ),
      ),
    );
  }
}
