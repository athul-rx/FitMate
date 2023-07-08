// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitmate/Components/button.dart';
import 'package:fitmate/Screens/person_detail.dart';
import 'package:fitmate/services/api_services.dart';
import 'package:fitmate/services/googleauth.dart';
import 'package:fitmate/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 70),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: MediaQuery.of(context).size.width / 1.4,
                height: MediaQuery.of(context).size.height / 5,
              ),
              Form(
                key: _formKey,
                child: SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 1.6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'HEY  \tTHERE!',
                        style: GoogleFonts.archivo(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 40),
                      textField("Name", false, _nameController),
                      textField('Email', false, _emailController),
                      textField('Password', true, _passwordController),
                      textField(
                          'Confirm Password', true, _confirmPasswordController),
                      Row(children: <Widget>[
                        Expanded(
                          child: Container(
                              margin: const EdgeInsets.only(
                                  left: 10.0, right: 15.0),
                              child: const Divider(
                                color: Colors.white,
                                height: 50,
                              )),
                        ),
                        const Text("OR"),
                        Expanded(
                          child: Container(
                              margin: const EdgeInsets.only(
                                  left: 15.0, right: 10.0),
                              child: const Divider(
                                color: Colors.white,
                                height: 50,
                              )),
                        ),
                      ]),
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 17,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              // primary: Colors.white,
                              // onPrimary: Colors.black,
                              backgroundColor: Colors.white),
                          onPressed: () {
                            // googleLogin();
                          },
                          child: GestureDetector(
                            onTap: () async {
                              await GoogleSignInProvider().signInWithGoogle();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PersonalDetails()),
                                  (route) => false);
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Image(
                                    image: AssetImage(
                                        "assets/images/google_logo.png"),
                                    height: 18.0,
                                    width: 24,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Sign in with Google',
                                    style: GoogleFonts.archivo(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // const SizedBox(height: 5),
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 17,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? true) {
                              _registerUser(
                                  context,
                                  _nameController.text,
                                  _emailController.text,
                                  _passwordController.text);
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Sign Up",
                                style: GoogleFonts.archivo(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 15),
                              const Icon(
                                Icons.arrow_forward,
                                color: Colors.black,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _registerUser(
      BuildContext context, String name, String email, String password) async {
    try {
      bool response = await APIServices().RegisterUser(name, email, password);
      log(response.toString());

      if (response) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const PersonalDetails(),
          ),
        );

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle, size: 48.0, color: Colors.green),
                    SizedBox(height: 16.0),
                    Text(
                      'Registration Successful!',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
    } catch (e) {
      log(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Something went wrong! Please try again',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
