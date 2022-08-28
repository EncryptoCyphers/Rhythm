// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import './drawerMenu.dart';

class HomePage extends StatelessWidget {
  String nm;

  HomePage({required this.nm});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        title: const Center(
          child: Text("RHYTHM"),
        ),
      ),
      drawer: const DrawerMenu(),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Text(
          'Welcome $nm',
          style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple),
        ),
      ),
    );
  }
}
