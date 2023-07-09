import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitmate/Screens/dashboard.dart';
import 'package:fitmate/Screens/home_screen.dart';
import 'package:fitmate/Screens/login_screen.dart';
import 'package:fitmate/Screens/nutrition.dart';
import 'package:fitmate/Screens/pose_detector_view.dart';
import 'package:fitmate/Screens/root.dart';
import 'package:fitmate/Screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

List<CameraDescription> cameras = [];
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  cameras = await availableCameras();
  runApp(const MyApp()); 
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget _defaultHome = const HomeScreen();

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        log('User is currently signed out!');
        setState(() {
          _defaultHome = const HomeScreen();
        });
      } else {
        log(user.uid);
        setState(() {
          _defaultHome = RootPage();
        });
      }
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitmate',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
            displayLarge: GoogleFonts.archivo(
                fontSize: 72.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
            titleLarge: GoogleFonts.archivo(
                fontSize: 36.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
            bodyMedium: GoogleFonts.archivo(
                fontSize: 14.0,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          )),
      home: RootPage(),
    );
  }
}
