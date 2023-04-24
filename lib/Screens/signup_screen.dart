import 'package:fitmate/Components/button.dart';
import 'package:fitmate/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'HEY THERE!',
                    style: GoogleFonts.archivo(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 40),
                  textField('Email', false, _emailController),
                  textField('Password', true, _passwordController),
                  textField('Confirm Password', true, _confirmPasswordController),
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
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 17,
                    child: ElevatedButton(
                    
                                  style: ElevatedButton.styleFrom(
                    // primary: Colors.white,
                    // onPrimary: Colors.black,
                    backgroundColor: Colors.white
                                  ),
                                  onPressed: () {
                    // googleLogin();
                                  },
                                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       const Image(
                          image: AssetImage("images/google_logo.png"),
                          height: 18.0,
                          width: 24,
                        ),
                        const SizedBox(width: 5,),
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
                  // const SizedBox(height: 5),
                  const Button(text: "SIGN UP", route: LoginScreen()),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
