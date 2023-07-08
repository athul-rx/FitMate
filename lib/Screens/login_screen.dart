import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitmate/Components/button.dart';
import 'package:fitmate/Screens/dashboard.dart';
import 'package:fitmate/Screens/home_screen.dart';
import 'package:fitmate/Screens/person_detail.dart';
import 'package:fitmate/widgets/text_field.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_button/sign_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
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
                height: MediaQuery.of(context).size.height / 4,
              ),
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 1.7,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Welcome Back',
                        style: GoogleFonts.archivo(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                      const SizedBox(height: 40),
                      textField('Email', false, emailController),
                      textField('Password', true, passwordController),
                      Row(children: <Widget>[
                        Expanded(
                          child: Container(
                              margin:
                                  const EdgeInsets.only(left: 10.0, right: 15.0),
                              child: const Divider(
                                color: Colors.white,
                                height: 50,
                              )),
                        ),
                        const Text("OR"),
                        Expanded(
                          child: Container(
                              margin:
                                  const EdgeInsets.only(left: 15.0, right: 10.0),
                              child: const Divider(
                                color: Colors.white,
                                height: 50,
                              )),
                        ),
                      ]),
                      SignInButton(
                          buttonType: ButtonType.google,
                          width: double.infinity,
                          buttonSize: ButtonSize.large,
                          shape: ShapeBorder.lerp(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              1),
                          onPressed: () {
                            if(_formKey.currentState?.validate() ?? true) {
                              log('Login with Google');
                            }
                          }),
                      Button(text: "Login", formKey: _formKey, fun: _login, route: const PersonalDetails()),
                      const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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

  void _login() async{
    if(_formKey.currentState?.validate() ?? true) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );
        if(userCredential.user != null) {

          log('${userCredential.user!.displayName} logged in \n\n\n\n\n\n');

          // ignore: use_build_context_synchronously
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) =>  Dashboard()),
                (Route<dynamic> route) => false,
          );
          // ignore: use_build_context_synchronously
          showDialog(
            context: context,
            builder: (BuildContext context) {
              Future.delayed(const Duration(seconds: 3), () {
                Navigator.of(context).pop(); // Close the dialog after 3 seconds
              });


              return Dialog(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const[
                      // Add your registration success UI here, such as an icon or image
                      Icon(Icons.check_circle, size: 48.0, color: Colors.green),
                      SizedBox(height: 16.0),
                      Text(
                        'Login Successful!',
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
          emailController.clear();
          passwordController.clear();

        }
        else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Something went wrong! Please try again.', style: TextStyle(color: Colors.white),),
              backgroundColor: Colors.red,

            ),
          );
        }


        //show the success message

        // ignore: use_build_context_synchronously

      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No user found for that email.', style: TextStyle(color: Colors.white),),
              backgroundColor: Colors.red,

            ),
          );
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Wrong password provided for that user.', style: TextStyle(color: Colors.white),),
              backgroundColor: Colors.red,

            ),
          );
        }
        // Handle other login errors if needed
        return null;
      }
    }
  }

  void autoLogin() {
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        log('User is currently signed out!');
      } else {
        log('User is signed in!');
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
              (Route<dynamic> route) => false,
        );
      }
    });
  }
}
