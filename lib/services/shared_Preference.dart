
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedServices {

  static Future<void> setLoginDetails() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    DocumentSnapshot<Map<String, dynamic>> snapshot =
    await FirebaseFirestore.instance.collection('users').doc(user!.email).get();


    List<String> details = [
      snapshot.data()!['name'],
      snapshot.data()!['email'],
      snapshot.data()!['password'],
      snapshot.data()!['height'],
      snapshot.data()!['weight'],
      snapshot.data()!['age'],
    ];
    log(details.toString());

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', details[1]);
    prefs.setString('password', details[2]);
    prefs.setString('name', details[0]);
    prefs.setString('height', details[3]);
    prefs.setString('weight', details[4]);
    prefs.setString('age', details[5]);

  }

  static getLoginDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    log(prefs.getString('name')!);
    Users details = Users(
        prefs.getString('name')!,
        prefs.getString('email')!,
        prefs.getString('password')!,
        prefs.getString('height')!,
        prefs.getString('weight')!,
        prefs.getString('age')!
    );

    return details;
  }
}

class Users {
  final String name;
  final String email;
  final String password;
  final String height;
  final String weight;
  final String age;

  Users(this.name, this.email, this.password, this.height, this.weight, this.age);
}