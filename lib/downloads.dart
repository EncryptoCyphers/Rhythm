import 'package:flutter/material.dart';

class Downloads extends StatelessWidget {
  const Downloads({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Downloads'),
        backgroundColor: Colors.purple,
      ),
      body: const Center(
        child: Text('Dummy Downloads Page'),
      ),
    );
  }
}
