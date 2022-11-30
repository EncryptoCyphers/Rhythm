import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../pages/user_profile.dart';

var name = "", username = "", email = "";
getData(String userEmail) {
  FirebaseFirestore.instance
      .collection('Rhythm_Users')
      .doc(userEmail)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      name = documentSnapshot.get("name").toString();
      username = documentSnapshot.get("username").toString();
      email = documentSnapshot.get("email").toString();
    }
  });
}

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  void initState() {
    super.initState();
    getData(FirebaseAuth.instance.currentUser!.email.toString());
  }

  @override
  Widget build(BuildContext context) {
    // getData(FirebaseAuth.instance.currentUser!.email.toString());
    return Container(
      margin: const EdgeInsets.all(15),
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        // color: Colors.amber,
        gradient: const LinearGradient(
          colors: [
            Color(0xff3d4eaf),
            Color(0xffea296a),
          ],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 1,
            left: 0,
            child: SvgPicture.asset(
              'svg/music.svg',
              height: 50,
              width: 50,
            ),
          ),
          Positioned(
            bottom: 1,
            right: 0,
            child: SvgPicture.asset(
              'svg/music1.svg',
              height: 50,
              width: 50,
            ),
          ),
          const Positioned(
            top: 15,
            right: 35,
            child: Text(
              'Profile Information',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.underline,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: 60,
            left: 10,
            child: Row(
              children: [
                const Icon(
                  Icons.person,
                  color: Colors.deepPurple,
                ),
                const SizedBox(width: 5),
                Text(
                  'Name: $name',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 90,
            left: 10,
            child: Row(
              children: [
                const Icon(
                  Icons.alternate_email,
                  color: Colors.deepPurple,
                ),
                const SizedBox(width: 5),
                Text(
                  'Username: $username',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 120,
            left: 10,
            child: Row(
              children: [
                const Icon(
                  Icons.email_rounded,
                  color: Colors.deepPurple,
                ),
                const SizedBox(width: 6),
                Text(
                  'Email: $email',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: -10,
            top: -7,
            child: IconButton(
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserProfile(),
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
