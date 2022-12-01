import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:music_player_app/services/colours.dart';
import 'package:music_player_app/widgets/profile_widget.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

//Update User Function
CollectionReference updateUsers =
    FirebaseFirestore.instance.collection('Rhythm_Users');
Future<void> updateUser(name, email, username) {
  // print('Updated Succesfully $id');
  return updateUsers
      .doc(email)
      .update({
        'name': name,
        'username': username,
      })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}

class _UserProfileState extends State<UserProfile> {
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var email = FirebaseAuth.instance.currentUser?.email;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Update Your Profile'),
        backgroundColor: fgPurple,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Profile Information',
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.teal,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Form(
              key: _formkey,
              child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                future: FirebaseFirestore.instance
                    .collection('Rhythm_Users')
                    .doc(email)
                    .get(),
                builder: (_, snapshot) {
                  if (snapshot.hasError) {
                    print('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    );
                  }
                  var data = snapshot.data!.data();
                  //Getting data from firebase server
                  var userEmail = data!['email'];
                  var userName = data['username'];
                  var name = data['name'];

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: TextFormField(
                            autofocus: false,
                            readOnly: true,
                            enabled: false,
                            initialValue: userEmail,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              filled: true,
                              prefixIcon: const Icon(
                                Icons.email_rounded,
                                color: Colors.deepPurple,
                              ),
                              fillColor: Colors.grey.shade200,
                              labelStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: TextFormField(
                            autofocus: false,
                            initialValue: name,
                            decoration: const InputDecoration(
                              labelText: 'Name',
                              prefixIcon: Icon(
                                Icons.person_rounded,
                                color: Colors.deepPurple,
                              ),
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.deepPurple,
                              ),
                              errorStyle: TextStyle(
                                color: Colors.red,
                                fontSize: 15,
                              ),
                            ),
                            onChanged: (value) => {name = value},
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Full Name';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: TextFormField(
                            autofocus: false,
                            initialValue: userName,
                            decoration: const InputDecoration(
                              labelText: 'Username',
                              prefixIcon: Icon(
                                Icons.alternate_email_rounded,
                                color: Colors.deepPurple,
                              ),
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.deepPurple,
                              ),
                              errorStyle: TextStyle(
                                color: Colors.red,
                                fontSize: 15,
                              ),
                            ),
                            onChanged: (value) => {userName = value},
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your username';
                              }
                              return null;
                            },
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              setState(() {
                                final snackBar = SnackBar(
                                  content: Text(
                                    userName + ' Updated Successfully',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  backgroundColor: Colors.deepOrangeAccent,
                                  dismissDirection: DismissDirection.horizontal,
                                  elevation: 10,
                                );

                                // Find the ScaffoldMessenger in the widget tree
                                // and use it to show a SnackBar.
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);

                                updateUser(name, userEmail, userName);
                                Navigator.pop(context);
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurpleAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 10,
                          ),
                          child: const Text('Update'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
