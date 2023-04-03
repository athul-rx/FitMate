import 'package:fitmate/widgets/TextField.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'images/logo.png',
              width: MediaQuery.of(context).size.width / 1.4,
              height: MediaQuery.of(context).size.height / 4,
            ),
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2,
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
                  const SizedBox(height: 20),
                  textField('Email', false, emailController),
                  textField('Password', true, passwordController),
                  Row(children: <Widget>[
                    Expanded(
                      child:  Container(
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
          ],
        ),
      ),
    );
  }
}
