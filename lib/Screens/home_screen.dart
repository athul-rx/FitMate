import 'package:flutter/material.dart';

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
              image: AssetImage('images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/logo.png',
                width: MediaQuery.of(context).size.width / 1.4,
                height: MediaQuery.of(context).size.height / 4,
              ),
              Image.asset(
                'assets/images/running.png',
                width: MediaQuery.of(context).size.width / 1.4 ,
                height: MediaQuery.of(context).size.height/2,
              ),
              const SizedBox(height: 20),
            
            ],
          ),
        ),
    
    );
  }
}
