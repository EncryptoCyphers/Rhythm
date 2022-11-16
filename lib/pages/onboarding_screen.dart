// ignore_for_file: avoid_unnecessary_containers, duplicate_ignore

import 'package:music_player_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:just_audio/just_audio.dart';
import 'package:email_validator/email_validator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key, required this.audioPlayer}) : super(key: key);
  final AudioPlayer audioPlayer;
  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _formkey = GlobalKey<FormState>();
  // ignore: non_constant_identifier_names
  final Controller = PageController();
  bool isLastPage = false;
  // ignore: unnecessary_new
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
              ),
            ),

            Form(
              key: _formkey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: ListView(
                  children: [
                    const Text(
                      'RHYTHM Music',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple),
                    ),
                    const Text(
                      'and',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const Text(
                      'MP3 Player.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: TextFormField(
                        autofocus: false,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.purple,
                              width: 3,
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.purple,
                              width: 2.0,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          errorStyle: const TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                          ),
                        ),
                        controller: _emailController,
                        validator: (value) {
                          if (!EmailValidator.validate(value!)) {
                            return 'Please enter valid email';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: TextFormField(
                        autofocus: false,
                        cursorColor: Colors.purple,
                        decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.purple,
                              width: 3,
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.purple,
                              width: 2.0,
                            ),
                          ),
                          labelText: 'Password',
                          labelStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          errorStyle: const TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                          ),
                        ),
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          } else if (value.length < 6) {
                            return 'Minimum Password Length is 6';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage
          // ? TextButton(
          //     style: TextButton.styleFrom(
          //         shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(00)),
          //         primary: Colors.white,
          //         backgroundColor: Colors.purpleAccent,
          //         minimumSize: const Size.fromHeight(80)),
          //     child: const Text(
          //       'Get Started',
          //       style: TextStyle(fontSize: 24),
          //     ),
          //     onPressed: () async {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => HomePage(
          //             nm: emailController.text,
          //             audioPlayer: widget.audioPlayer,
          //           ),
          //         ),
          //       );
          //     },
          //   )
          ? Container(
              margin: EdgeInsets.all(20),
              padding: const EdgeInsets.all(0),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  animationDuration: const Duration(seconds: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  shadowColor: Colors.purple,
                  primary: Colors.purple,
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    setState(
                      () {
                        const snackBar = SnackBar(
                          content: Text('Added Succesfully'),
                          backgroundColor: Colors.green,
                          dismissDirection: DismissDirection.horizontal,
                          elevation: 10,
                        );
                        var name =
                            _emailController.text.split('@')[0].toUpperCase();
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(
                              nm: name,
                              audioPlayer: widget.audioPlayer,
                            ),
                          ),
                        );
                      },
                    );
                  }

                  // print(_emailController.text.split(' ').toString());
                },
              ),
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
