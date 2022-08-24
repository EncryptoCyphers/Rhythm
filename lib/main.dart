import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Center(child: const Text('Rhythm')),
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
