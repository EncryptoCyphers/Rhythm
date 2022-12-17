import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_player_app/services/colours.dart';
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
          // return const Center(
          //   child: CircularProgressIndicator(
          //     color: Colors.red,
          //   ),
          // );
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: LoadingAnimationWidget.inkDrop(
                color: Colors.deepPurple,
                size: 50,
              ),
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
          height: MediaQuery.of(context).size.height * 0.25,
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
            color: bgPurple,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              const Positioned(
                top: 15,
                left: 15,
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
                top: 70,
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
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 110,
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
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 150,
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
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: -10,
                top: -10,
                child: TextButton(
                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 25,
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
