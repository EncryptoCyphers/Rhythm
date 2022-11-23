import 'package:flutter/material.dart';

class WebPage extends StatefulWidget {
  const WebPage({Key? key}) : super(key: key);

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Center(
          child: Text('Dummy WebPage Page'),
        ),
      ],
    );
  }
}
