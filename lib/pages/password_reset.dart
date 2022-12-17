/*
 *  This file is part of Rhythm (https://github.com/EncryptoCyphers/Rhythm).
 * 
 * Rhythm is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Rhythm is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with Rhythm.  If not, see <http://www.gnu.org/licenses/>.
 * 
 * Copyright (c) 2022-2023, EncryptoCyphers
 */
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({super.key});

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  final _formkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  //Reset Password Method
  Future resetPassword() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          color: Colors.green,
        ),
      ),
    );
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: _emailController.text.trim());
    const snackBar = SnackBar(
      content: Text(
        'Email sent successfully. Check spam folder also',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      duration: Duration(seconds: 5),
      backgroundColor: Colors.green,
    );
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // ignore: use_build_context_synchronously
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Password Reset'),
        elevation: 8,
        centerTitle: true,
        backgroundColor: Colors.pink,
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            Image.asset(
              'images/forgot_password.png',
              height: 200,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'A password reset email will be sent to this email',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: TextFormField(
                autofocus: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  floatingLabelStyle: const TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                  labelText: 'Email',
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepPurple,
                      width: 3,
                    ),
                  ),
                  hintText: 'Please enter a valid Email',
                  prefixIcon: const Icon(
                    Icons.email,
                    color: Colors.pink,
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
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(0),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    resetPassword();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  elevation: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.lock_rounded),
                    Text(
                      '  Reset Password',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
