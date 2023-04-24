import 'package:fitmate/Screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Components/button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: MediaQuery.of(context).size.width / 1.4,
                height: MediaQuery.of(context).size.height / 4,
              ),
              Image.asset(
                'assets/images/running.png',
                width: MediaQuery.of(context).size.width / 1.4 ,
                height: MediaQuery.of(context).size.height/2,
              ),
              const SizedBox(height: 20),
              const Button(text: "START YOUR JOURNEY",route: LoginScreen(),),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                 
                },
                child:Text(
                  "ALREADY HAVE AN ACCOUNT? LOGIN",
                   style: GoogleFonts.archivo(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                ),
              ),
              )]
          ),
        ),
    
    );
  }
}
