import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:launch_review/launch_review.dart';

final Uri _url = Uri.parse('https://www.linkedin.com/in/ankit-paul-914936234/');
final Uri _url2 = Uri.parse('https://www.linkedin.com/in/arpan-de-001ab31b9/');
final Uri _url3 = Uri.parse('https://www.linkedin.com/in/arnab7070/');
final Uri _url4 =
    Uri.parse('https://www.linkedin.com/in/bishal-karmakar-2a234623a/');

class AppInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
          ),
          Image.asset('images/app_icon.jpg', height: 150),
          Text(
            'RHYTHM Music & MP3 Player',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.deepPurple),
          ),
          Text(
            'v1.0.0',
            style: TextStyle(fontSize: 20, color: Colors.deepPurple),
          ),
          Container(
            height: 40,
          ),
          Text(
            'This is an open source project and can be found on',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          FlatButton(
            onPressed: () {},
            child: Text(
              'GitHub',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          Text(
            'If you liked our work',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          Text(
            'show some ❤ and ⭐ the repository',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          Text(
            'and rate us on',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          FlatButton(
            onPressed: () {
              LaunchReview.launch(androidAppId: "com.android.chrome");
            },
            child: Text(
              'Google Play',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          Container(
            height: 40,
          ),
          Text(
            'Made with ❤ by',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
              fontSize: 15,
            ),
          ),
          SizedBox(
            height: 25,
            child: FlatButton(
              onPressed: _launchUrl3,
              child: Text(
                'Arnab Nandi',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 25,
            child: FlatButton(
              onPressed: _launchUrl4,
              child: Text(
                'Bishal Karmakar',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 25,
            child: FlatButton(
              onPressed: _launchUrl,
              child: Text(
                'Ankit Paul',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 25,
            child: FlatButton(
              onPressed: _launchUrl2,
              child: Text(
                'Arpan De',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
}

Future<void> _launchUrl2() async {
  if (!await launchUrl(_url2)) {
    throw 'Could not launch $_url2';
  }
}

Future<void> _launchUrl3() async {
  if (!await launchUrl(_url3)) {
    throw 'Could not launch $_url3';
  }
}

Future<void> _launchUrl4() async {
  if (!await launchUrl(_url4)) {
    throw 'Could not launch $_url4';
  }
}
