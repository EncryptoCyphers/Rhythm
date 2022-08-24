import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Center(
          child: Text('Rythm'),
        ),
      ),
      drawer: Drawer(
        child: Container(
          margin:
          const EdgeInsets.only(top: 50, left: 20, bottom: 50, right: 20),
          // ignore: sized_box_for_whitespace
          child: Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.all(15),
            child: const Text(
              'Menu',
              style: TextStyle(
                color: Colors.black,
                fontSize: 35,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
