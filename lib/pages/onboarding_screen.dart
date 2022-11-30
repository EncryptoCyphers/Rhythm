// ignore_for_file: avoid_unnecessary_containers, duplicate_ignore
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:music_player_app/pages/home_page.dart';
import 'package:music_player_app/pages/password_reset.dart';
import 'package:music_player_app/pages/signup.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';

var username;

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({
    Key? key,
  }) : super(key: key);
  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

String getData(String email) {
  FirebaseFirestore.instance
      .collection('Rhythm_Users')
      .doc(email)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      username = documentSnapshot.get("username").toString();
    } else {
      username = email.split('@')[0];
    }
  });
  print(username);
  return username;
}

class _OnboardingPageState extends State<OnboardingPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  bool isLoading = false;
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
      backgroundColor: Colors.white,
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
                    Image.asset('images/login.png'),
                    const Text(
                      'Sign In',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: TextFormField(
                        autofocus: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Please enter your email',
                          prefixIcon: const Icon(
                            Icons.email_rounded,
                            color: Colors.deepPurple,
                          ),
                          floatingLabelStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                          labelStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.deepPurple,
                              width: 3,
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.deepPurple,
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
                        obscureText: true,
                        decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.deepPurple,
                              width: 3,
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.deepPurple,
                              width: 2.0,
                            ),
                          ),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.deepPurple,
                          ),
                          labelText: 'Password',
                          hintText: 'Please enter your password',
                          floatingLabelStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
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
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUp(
                                  name: _emailController.text
                                      .split('@')[0]
                                      .toUpperCase(),
                                ),
                              ));
                        },
                        child: const Text(
                          'Not a member? Create account here',
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: GestureDetector(
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.red,
                            fontSize: 15,
                          ),
                        ),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PasswordReset(),
                          ),
                        ),
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
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(0),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.all(12),
                  animationDuration: const Duration(seconds: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  shadowColor: Colors.redAccent,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.login_outlined),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
                onPressed: () async {
                  //Login Method

                  if (_formkey.currentState!.validate()) {
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        final snackBar = SnackBar(
                          content: const Text(
                            'No user found',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          action: SnackBarAction(
                            label: 'Create Account',
                            textColor: Colors.white,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => SignUp(
                                        name:
                                            _emailController.text.split('@')[0],
                                      )),
                                ),
                              );
                            },
                          ),
                          backgroundColor: Colors.pink,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else if (e.code == 'wrong-password') {
                        const snackBar = SnackBar(
                          content: Text(
                            'Wrong password !!!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          backgroundColor: Colors.red,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else if (e.code == 'invalid-email') {
                        const snackBar = SnackBar(
                          content: Text(
                            'Invalid email !!!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          backgroundColor: Colors.blue,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else if (e.code == 'user-disabled') {
                        const snackBar = SnackBar(
                          content: Text(
                            'User is disabled by admin',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          backgroundColor: Colors.orangeAccent,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    } catch (e) {
                      // print(e);
                    }
                  }

                  //Check Method
                  FirebaseAuth.instance
                      .authStateChanges()
                      .listen((User? user) async {
                    if (user != null) {
                      if (isLoading) return;
                      setState(() {
                        isLoading = true;
                      });
                      // await Future.delayed(const Duration(seconds: 1));
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(
                              nm: getData(_emailController.text),
                              // nm: _emailController.text.split('@')[0],
                            ),
                          ),
                        );
                      });
                    }
                  });
                },
              ),
            )

          // ignore: sized_box_for_whitespace

          // Navigator.push(
          //                   context,
          //                   MaterialPageRoute(
          //                     builder: (context) => HomePage(
          //                       nm: name,
          //                       audioPlayer: widget.audioPlayer,
          //                     ),
          //                   ),
          //                 );

          : SizedBox(
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
