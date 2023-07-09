import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fitmate/Screens/dashboard.dart';
import 'package:fitmate/Screens/nutrition.dart';
import 'package:fitmate/Screens/profile_screen.dart';
import 'package:fitmate/Screens/workout_page1.dart';
import 'package:flutter/material.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {

  int _bottomNavIndex = 0;

  //List of the pages
  List<Widget> _widgetOptions() {
    return [
      Dashboard(),
      const MyNutrition(),
      const MyWorkourtPage1(),
      ProfileScreen()
    ];
  }

  //List of the pages icons
  List<IconData> iconList = [
    Icons.home,
    Icons.favorite,
    Icons.health_and_safety,
    Icons.person,
  ];

  //List of the pages titles
  List<String> titleList = [
    'Home',
    'Favorite',
    'Plant Disease Detection',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _bottomNavIndex,
        children: _widgetOptions(),
      ),
      
      bottomNavigationBar: CurvedNavigationBar(
        index: _bottomNavIndex, 
        color: Colors.black,
        backgroundColor: Color.fromARGB(126, 113, 111, 113).withOpacity(0.2),
        height: 60,
        items: iconList
            .map(
              (e) => Icon(
                e,
                size: 30,
                color: Colors.white,
              ),
            )
            .toList(),
        animationDuration: const Duration(milliseconds: 200),
        animationCurve: Curves.bounceInOut,
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
          });
        },
      )
    );
  }
}
