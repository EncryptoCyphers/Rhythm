// ignore_for_file: avoid_unnecessary_containers, duplicate_ignore

import 'package:music_player_app/home_page.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:just_audio/just_audio.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key, required this.audioPlayer}) : super(key: key);
  final AudioPlayer audioPlayer;
  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  // ignore: non_constant_identifier_names
  final Controller = PageController();
  bool isLastPage = false;
  // ignore: unnecessary_new
  TextEditingController textcontroller = new TextEditingController();

  @override
  void dispose() {
    Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: Controller,
          onPageChanged: (index) {
            setState(() => isLastPage = index == 2);
          },
          children: [
            // ignore: avoid_unnecessary_containers
            Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                ),
                Image.asset('images/listen_to_music.png'),
                const Text(
                  'Listen To Your Favourite',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.purpleAccent),
                ),
                const Text(
                  'Songs Add-Free',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.purpleAccent),
                )
              ],
            )),
            // ignore: avoid_unnecessary_containers
            Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                ),
                Image.asset(
                  'images/playlist.png',
                ),
                const Text(
                  'Create your own',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.purpleAccent),
                ),
                const Text(
                  'Personalised playlist',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.purpleAccent),
                )
              ],
            )),
            Container(
                child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(0, 125, 0, 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                  ),
                  const Text(
                    'RHYTHM Music',
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple),
                  ),
                  const Text(
                    'and',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const Text(
                    'MP3 Player.',
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  TextField(
                    controller: textcontroller,
                    decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.purpleAccent, width: 3)),
                        labelText: 'Enter Your Name',
                        labelStyle: TextStyle(fontSize: 25),
                        prefixIcon:
                            Icon(Icons.person, color: Colors.purpleAccent)),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                  )
                ],
              ),
            )),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(00)),
                  primary: Colors.white,
                  backgroundColor: Colors.purpleAccent,
                  minimumSize: const Size.fromHeight(80)),
              child: const Text(
                'Get Started',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage(
                              nm: textcontroller.text,
                              audioPlayer: widget.audioPlayer,
                            )));
              },
            )
          // ignore: sized_box_for_whitespace
          : Container(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: const Text(
                      'SKIP',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () => Controller.jumpToPage(2),
                  ),
                  Center(
                    child: SmoothPageIndicator(
                      controller: Controller,
                      count: 3,
                      effect: const WormEffect(
                        spacing: 16,
                        dotColor: Colors.black26,
                        activeDotColor: Colors.purpleAccent,
                      ),
                      onDotClicked: (index) => Controller.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      ),
                    ),
                  ),
                  TextButton(
                    child: const Text(
                      'NEXT',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () => Controller.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
