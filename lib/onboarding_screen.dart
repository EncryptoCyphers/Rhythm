import 'package:music_player_app/home_page.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {

  final Controller = PageController();
  bool isLastPage = false;
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
            Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                    ),
                    Image.asset('images/listen_to_music.png'),
                    Text(
                      'Listen To Your Favourite',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.purpleAccent
                      ),
                    ),
                    Text(
                      'Songs Add-Free',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.purpleAccent
                      ),
                    )
                  ],
                )
            ),
            Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                    ),
                    Image.asset('images/playlist.png'),
                    Text(
                      'Create your own',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.purpleAccent
                      ),
                    ),
                    Text(
                      'Personalised playlist',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.purpleAccent
                      ),
                    )
                  ],
                )
            ),
            Container(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(0, 125, 0, 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                      ),
                      Text(
                        'RHYTHM Music',
                        style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple
                        ),
                      ),
                      Text(
                        'and',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'MP3 Player.',
                        style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      TextField(
                        controller: textcontroller,
                        decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.purpleAccent, width: 3)
                            ),
                            labelText: 'Enter Your Name',
                            labelStyle: TextStyle(
                                fontSize: 25
                            ),
                            prefixIcon: Icon(Icons.person, color: Colors.purpleAccent)
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                      )
                    ],
                  ),
                )
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
        style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(00)
            ),
            primary: Colors.white,
            backgroundColor: Colors.purpleAccent,
            minimumSize: const Size.fromHeight(80)
        ),
        child: Text(
          'Get Started',
          style: TextStyle(
              fontSize: 24
          ),
        ),
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage(nm: textcontroller.text))
          );
        },
      )
          : Container(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              child: Text('SKIP',
                style: TextStyle(
                    fontSize: 20
                ),
              ),
              onPressed: () => Controller.jumpToPage(2),
            ),
            Center(
              child: SmoothPageIndicator(
                controller: Controller,
                count: 3,
                effect: WormEffect(
                  spacing: 16,
                  dotColor: Colors.black26,
                  activeDotColor: Colors.purpleAccent,
                ),
                onDotClicked: (index) => Controller.animateToPage(
                  index,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                ),
              ),
            ),
            TextButton(
              child: Text('NEXT',
                style: TextStyle(
                    fontSize: 20
                ),
              ),
              onPressed: () => Controller.nextPage(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              ),
            )
          ],
        ),
      ),
    );
  }
}
