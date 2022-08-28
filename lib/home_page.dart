import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  String nm;


  HomePage({required this.nm});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Center(
          child: Text("RHYTHM"),
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: const Color.fromARGB(255, 167, 147, 240),
          margin: EdgeInsets.zero,
          padding: const EdgeInsets.fromLTRB(0, 40, 0, 25),
          // margin:
          //     const EdgeInsets.only(top: 30, left: 20, bottom: 30, right: 20),
          // ignore: sized_box_for_whitespace
          child: Container(
            alignment: Alignment.topCenter,
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
      body: Container(
        child: Text(
          'Welcome ${nm}',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple
          ),
        ),
      ),
    );
  }
}
