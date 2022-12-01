import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../pages/user_profile.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> usersStream =
        FirebaseFirestore.instance.collection('Rhythm_Users').snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          );
        }

        final List storeData = []; //Creating a list to storeData
        snapshot.data!.docs.map((DocumentSnapshot document) {
          Map a = document.data() as Map<String, dynamic>;
          storeData.add(a);
        }).toList();

        int userIndex = 0;
        for (int i = 0; i < storeData.length; i++) {
          if (storeData[i]['email'] ==
              FirebaseAuth.instance.currentUser!.email.toString()) {
            userIndex = i;
            break;
          }
        }

        var name = storeData[userIndex]['name'];
        var email = storeData[userIndex]['email'];
        var username = storeData[userIndex]['username'];

        return Container(
          margin: const EdgeInsets.all(15),
          height: MediaQuery.of(context).size.height * 0.35,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            // color: Colors.greenAccent,
            boxShadow: const [
              BoxShadow(
                color: Colors.deepPurple,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 10.0,
                spreadRadius: 2.0,
                blurStyle: BlurStyle.normal,
              ),
            ],
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 213, 107, 179),
                Color.fromRGBO(51, 16, 245, 1),
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
                  'svg/music1.svg',
                  height: 50,
                  width: 50,
                ),
              ),
              Positioned(
                bottom: 1,
                left: 0,
                child: SvgPicture.asset(
                  'svg/music5.svg',
                  height: 90,
                  width: 90,
                ),
              ),
              Positioned(
                bottom: 1,
                right: 0,
                child: SvgPicture.asset(
                  'svg/music2.svg',
                  height: 90,
                  width: 90,
                ),
              ),
              const Positioned(
                top: 35,
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
                top: 90,
                left: 10,
                child: Row(
                  children: [
                    const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '$name',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 125,
                left: 10,
                child: Row(
                  children: [
                    const Icon(
                      Icons.alternate_email,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '$username',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 160,
                left: 10,
                child: Row(
                  children: [
                    const Icon(
                      Icons.email_rounded,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '$email',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 0,
                top: -10,
                child: TextButton(
                  child: Row(
                    children: const [
                      Icon(
                        Icons.edit,
                        color: Colors.black,
                        size: 20,
                      ),
                      Text(
                        'Edit',
                        style: TextStyle(
                          color: Colors.black,
                          // fontSize: 20,
                        ),
                      ),
                    ],
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
      },
    );
  }
}
