import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class SignUp extends StatefulWidget {
  final String name;
  const SignUp({super.key, required this.name});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPassword = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = false;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Sign Up'),
        elevation: 8,
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          children: [
            const SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.edit,
                  color: Colors.deepPurple,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Create Account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 200,
              child: Image.asset(
                'images/sign_up.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: TextFormField(
                autofocus: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter valid email e.g. test@gmail.com',
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
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
                obscureText: true,
                cursorColor: Colors.purple,
                decoration: InputDecoration(
                  hintText: 'Minimum password length 6',
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
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
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
              margin: const EdgeInsets.all(10),
              child: TextFormField(
                autofocus: false,
                obscureText: true,
                cursorColor: Colors.purple,
                decoration: InputDecoration(
                  hintText: 'Please re-enter your password',
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
                  labelText: 'Confirm Password',
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  errorStyle: const TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                  ),
                ),
                controller: _confirmPassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  } else if (value.length < 6) {
                    return 'Minimum Password Length is 6';
                  } else if (value != _passwordController.text) {
                    return 'Password doesn\'t match';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(0),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  backgroundColor: Colors.purple,
                  padding: const EdgeInsets.all(12),
                  animationDuration: const Duration(seconds: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  shadowColor: Colors.purple,
                ),
                child: isLoading
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(
                            color: Colors.white,
                          ),
                          SizedBox(width: 24),
                          Text(
                            'Please Wait...',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.account_box),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Create Account',
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                onPressed: () async {
                  //Sign Up Method
                  if (_formkey.currentState!.validate()) {
                    try {
                      UserCredential userCredential = await FirebaseAuth
                          .instance
                          .createUserWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                      if (isLoading) return;
                      setState(() {
                        isLoading = true;
                      });
                      await Future.delayed(const Duration(seconds: 3));
                      CollectionReference users =
                          FirebaseFirestore.instance.collection('Rhythm_Users');
                      users
                          .add({
                            'email': _emailController.text, // John Doe
                          })
                          .then((value) => print("User Added"))
                          .catchError(
                              (error) => print("Failed to add user: $error"));
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(
                              nm: widget.name,
                            ),
                          ),
                        );
                      });
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        const snackBar = SnackBar(
                          content: Text(
                            'Password is too weak',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          backgroundColor: Colors.red,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else if (e.code == 'email-already-in-use') {
                        const snackBar = SnackBar(
                          content: Text(
                            'Email is already in use',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          backgroundColor: Colors.red,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    } catch (e) {
                      // print(e);
                    }
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
