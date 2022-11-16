import 'package:flutter/material.dart';

class Playlist extends StatelessWidget {
  const Playlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Playlist'),
        backgroundColor: Colors.purple,
      ),
      body: const Center(
        child: Text('Dummy Playlist Page'),
      ),
    );
  }
}
