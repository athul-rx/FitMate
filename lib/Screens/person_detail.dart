import 'package:fitmate/Components/button.dart';
import 'package:fitmate/widgets/TextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'images/logo1.png',
              width: MediaQuery.of(context).size.width / 1.4,
              height: MediaQuery.of(context).size.height / 13,
            ),
            Container(
              child: Column(
                children: [
                  Text(
                    "Hello! My name is FitMate, and I'm here to help you with your fitness goals.",
                    style: GoogleFonts.archivo(
                        color: Colors.white, fontSize: 20, letterSpacing: 2),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "To help us provide you with personalized workout recommendations, we need some basic physical information from you. ",
                    style: GoogleFonts.archivo(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 15,
                        letterSpacing: 2),
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 3.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  textField("Height", false, _heightController),
                  textField("Weight", false, _weightController),
                  textField("Age", false, _ageController)
                ],
              ),
            ),
            Text(
              "Thank you for helping us improve your fitness journey!",
              style: GoogleFonts.archivo(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 15,
                  letterSpacing: 2),
            ),

            const SizedBox(height: 20),

            const Button(text: "Continue", route: PersonalDetails())
          ],
        ),
      ),
    );
  }
}
