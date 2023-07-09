import 'package:fitmate/Components/daily_workout_conatiner.dart';
import 'package:fitmate/Screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

class MyWorkourtPage1 extends StatefulWidget {
  const MyWorkourtPage1({super.key});

  @override
  State<MyWorkourtPage1> createState() => _MyWorkourtPage1State();
}

class _MyWorkourtPage1State extends State<MyWorkourtPage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 21, 21, 21),
            elevation: 2,
            leadingWidth: 50,
            actions: [
              Image.asset(
              'assets/images/logo1.png',
              width: 50,
              height: 50,
            ),
            ]
      ),
        body: SingleChildScrollView(
      child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 1.15,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "My Activity",
                style: GoogleFonts.archivo(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 4,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 12, 12, 12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, bottom: 15, top: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ongoing Workout",
                        style: GoogleFonts.archivo(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Divider(
                        color: Colors.white,
                        thickness: 1,
                      ),
                      // const SizedBox(height: 10),
                      Text(
                        "Arm Workout",
                        style: GoogleFonts.archivo(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // const SizedBox(height: 5),
                      Text(
                        "5 sets",
                        style: GoogleFonts.archivo(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 5),
                      LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width - 100,
                        animation: true,
                        lineHeight: 15.0,
                        animationDuration: 2500,
                        percent: 0.8,
                        center: const Text("80.0%"),
                        // linearStrokeCap: LinearStrokeCap.roundAll,
                        barRadius: const Radius.circular(10),
                        progressColor: Colors.green,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const DailyWorkoutContainer(
                  imageURL: "assets/images/biceps.png",
                  title: "Biceps Workout",
                  subtitle: "200",
                  buttonText: "continue",
                  blackContainer: true),
              const SizedBox(height: 10),
              const DailyWorkoutContainer(
                  imageURL: "assets/images/fullbody.png",
                  title: "Fullbody Workout",
                  subtitle: "200",
                  buttonText: "continue",
                  blackContainer: true),
              const SizedBox(height: 20),
              Text(
                "All Workouts",
                style: GoogleFonts.archivo(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              const DailyWorkoutContainer(
                  imageURL: "assets/images/bicepsBlack.png",
                  title: "Pushup Workout",
                  subtitle: "25",
                  buttonText: "continue",
                  blackContainer: false),
              // const SizedBox(height: 10),
              // const DailyWorkoutContainer(
              //     imageURL: "assets/images/fullbody2.png",
              //     title: "Fullbody Workout",
              //     subtitle: "200",
              //     buttonText: "continue",
              //     blackContainer: false),
              // const SizedBox(height: 10),
              // const DailyWorkoutContainer(
              //     imageURL: "assets/images/fullbody2.png",
              //     title: "Fullbody Workout",
              //     subtitle: "200",
              //     buttonText: "continue",
              //     blackContainer: false),
            ],
          )),
    ));
  }
}
