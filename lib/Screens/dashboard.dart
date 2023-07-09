import 'dart:async';
import 'dart:math';
import 'dart:developer';
import 'package:confetti/confetti.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:fitmate/Screens/activity.dart';
import 'package:fitmate/Screens/profile_screen.dart';
import 'package:fitmate/Screens/workout_page1.dart';
import 'package:fitmate/widgets/bar_chart.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
// import 'package:sensors/sensors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  bool isparty = false;
  Dashboard({super.key, this.isparty = false});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<double> weeklySteps = [1000, 2000, 3000, 4000, 5000, 6000, 7000];
  SharedPreferences? prefs;
  int stepCount = 0;
  double caloriesBurned = 0.0;
  bool isListening = false;
  int prevStepCount = 0;
  String name = "";

  late Timer _restTimer;
  late ConfettiController _controllerCenter;

  void getData() async {
    prefs = await SharedPreferences.getInstance();
    name = prefs!.getString('name') ?? "";
  }

  @override
  void initState() {
    super.initState();
    getData();
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 2));
    // startListening();
    _startResetTimer();
    fetchCaloriesForCurrentUser("UVknNkzc2ONKpcAsgkzMLCo5m8t2");

    if (widget.isparty) {
      _controllerCenter.play();
    }
  }

  void startListening() {
    double threshold =
        50; // Adjust this value based on accelerometer sensitivity

    double prevMagnitude = 0.0;
    double currentMagnitude = 0.0;
    bool peakDetected = false;

    accelerometerEvents.listen((AccelerometerEvent event) {
      double x = event.x;
      double y = event.y;
      double z = event.z;

      currentMagnitude = sqrt(x * x + y * y + z * z);

      if (currentMagnitude > threshold && prevMagnitude - 10 < threshold) {
        // Peak detected
        peakDetected = true;
      }

      if (peakDetected) {
        setState(() {
          stepCount++;
        });
        peakDetected = false;
      }

      prevMagnitude = currentMagnitude;
    });
  }

  void calculateCaloriesBurned(int stepCount, double weightInKg) {
    // Constants for calorie calculation
    const double MET = 3.6; // Metabolic Equivalent of Task for walking
    const double CALORIES_PER_KG_PER_HOUR =
        70.0; // Calories burned per kg of body weight per hour

    // Estimate stride length in meters based on average values
    double strideLengthInMeters = 0.415; // Average stride length for adults

    // Convert step count to distance in meters
    double distanceInMeters = stepCount * strideLengthInMeters;

    // Calculate time in hours assuming an average walking speed of 5 km/h
    double timeInHours = distanceInMeters / 5000; // 1 hour = 5 km

    // Calculate calories burned based on the formula: calories = MET * weight * time
    double caloriesBurneds = MET * weightInKg * timeInHours;
    setState(() {
      caloriesBurned = caloriesBurneds;
    });
  }

  void setprefData(int predistance) async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    pre.setInt('previousStep', predistance);
  }

  void getprefData() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    setState(() {
      prevStepCount = pre.getInt('previousStep') ?? 0;
    });
  }

  void _startResetTimer() {
    const oneDay = Duration(days: 1);
    _restTimer = Timer(oneDay, () {
      setState(() {
        stepCount = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    startListening();
    calculateCaloriesBurned(stepCount, 0.4);
    double progress = stepCount / 10000;

    return (Scaffold(
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
            ]),
        body: StreamBuilder<AccelerometerEvent>(
            stream: SensorsPlatform.instance.accelerometerEvents,
            builder: (context, snapshot) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/background.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: ListView(
                      children: [
                        Text(
                          "Good Day, $name!",
                          style: GoogleFonts.archivo(
                            color: Colors.white,
                            fontSize: 30,
                            letterSpacing: 2,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Tracking your daily activity and stay healthy",
                          style: GoogleFonts.archivo(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 15,
                            letterSpacing: 2,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height / 2.5,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 21, 21, 21),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "You've walked $stepCount steps!",
                                style: GoogleFonts.archivo(
                                  color: Colors.white,
                                  fontSize: 20,
                                  letterSpacing: 2,
                                ),
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  const SizedBox(
                                    height: 120,
                                    width: 120,
                                    child: CircularProgressIndicator(
                                      value: 0.75,
                                      strokeWidth: 8,
                                      backgroundColor:
                                          Color.fromARGB(255, 0, 255, 148),
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Color.fromARGB(255, 75, 72, 72),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Icon(Icons.directions_walk,
                                          color: Colors.white),
                                      Text(
                                        stepCount.toString(),
                                        style: GoogleFonts.archivo(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 2,
                                        ),
                                      ),
                                      Text(
                                        "steps",
                                        style: GoogleFonts.archivo(
                                          color: Colors.white.withOpacity(0.7),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 2,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //for calories
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.local_fire_department,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                caloriesBurned
                                                    .toStringAsFixed(2),
                                                style: GoogleFonts.archivo(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  letterSpacing: 4,
                                                ),
                                              ),
                                              Text(
                                                "Calories ",
                                                style: GoogleFonts.archivo(
                                                  color: Colors.white
                                                      .withOpacity(0.7),
                                                  fontSize: 15,
                                                  letterSpacing: 2,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  //vertical line
                                  Container(
                                    height: 30,
                                    width: 1,
                                    color: Colors.white.withOpacity(0.7),
                                  ),

                                  //for steps

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.directions_walk,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "10000",
                                                style: GoogleFonts.archivo(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  letterSpacing: 4,
                                                ),
                                              ),
                                              Text(
                                                "Daily Goal",
                                                style: GoogleFonts.archivo(
                                                  color: Colors.white
                                                      .withOpacity(0.7),
                                                  fontSize: 15,
                                                  letterSpacing: 2,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        //for the middle container

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ActivityPage()));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2.5,
                                height: MediaQuery.of(context).size.height / 4,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 231, 254, 85),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "Daily Progress",
                                      style: GoogleFonts.archivo(
                                        color: Colors.black,
                                        fontSize: 20,
                                        letterSpacing: 2,
                                      ),
                                    ),
                                    SizedBox(
                                        height: 120,
                                        width: 200,
                                        child: BarChartWidget(
                                          showtitle: false,
                                        )),
                                    // Text(
                                    //   "23.4",
                                    //   style: GoogleFonts.archivo(
                                    //     color: Colors.black,
                                    //     fontSize: 30,
                                    //     letterSpacing: 2,
                                    //   ),
                                    // ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const Icon(
                                          Icons.directions_run,
                                          color: Colors.black,
                                        ),
                                        Text(
                                          "3",
                                          style: GoogleFonts.archivo(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 2,
                                          ),
                                        ),
                                        Text(
                                          "Hours",
                                          style: GoogleFonts.archivo(
                                            color:
                                                Colors.black.withOpacity(0.7),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 2,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              height: MediaQuery.of(context).size.height / 3.5,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 38, 233, 229),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Calories",
                                    style: GoogleFonts.archivo(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      letterSpacing: 2,
                                    ),
                                  ),

                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: CircularProgressIndicator(
                                          value: 0.5,
                                          strokeWidth: 8,
                                          backgroundColor: const Color.fromARGB(
                                                  255, 179, 172, 172)
                                              .withOpacity(0.7),
                                          valueColor:
                                              const AlwaysStoppedAnimation<
                                                  Color>(Colors.black),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.local_fire_department,
                                            color: Colors.black,
                                          ),
                                          Text(
                                            "1000",
                                            style: GoogleFonts.archivo(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 2,
                                            ),
                                          ),
                                          Text(
                                            "Cal",
                                            style: GoogleFonts.archivo(
                                              color:
                                                  Colors.black.withOpacity(0.7),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 2,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  // Text(
                                  //   "23.4",
                                  //   style: GoogleFonts.archivo(
                                  //     color: Colors.white,
                                  //     fontSize: 30,
                                  //     letterSpacing: 2,
                                  //   ),
                                  // ),
                                  // for calories value
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.local_fire_department,
                                        color: Colors.black,
                                      ),
                                      Text(
                                        "1 ",
                                        style: GoogleFonts.archivo(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 2,
                                        ),
                                      ),
                                      Text(
                                        "Kcal",
                                        style: GoogleFonts.archivo(
                                          color: Colors.black.withOpacity(0.7),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 2,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        GlassmorphicContainer(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height / 4,
                          borderRadius: 20,
                          linearGradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color(0xFFffffff).withOpacity(0.1),
                              const Color(0xFFFFFFFF).withOpacity(0.05),
                            ],
                            stops: const [0.1, 1],
                          ),
                          border: 0,
                          blur: 7,
                          borderGradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color(0xFFffffff).withOpacity(0.5),
                              const Color(0xFFFFFFFF).withOpacity(0.5),
                            ],
                            stops: const [0.1, 1],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //ongoing workout and icon in a row
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Ongoing Workout",
                                      style: GoogleFonts.archivo(
                                        fontSize: 20,
                                        color: Colors.white.withOpacity(0.7),
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2,
                                      ),
                                    ),
                                    Icon(
                                      Icons.directions_run,
                                      color: Colors.white.withOpacity(0.7),
                                    ),
                                  ],
                                ),

                                //horizontal line
                                Container(
                                  height: 1,
                                  width: double.infinity,
                                  color: Colors.white.withOpacity(0.7),
                                ),

                                //Bicesps workout text
                                Text(
                                  "Biceps Workout",
                                  style: GoogleFonts.archivo(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                  ),
                                ),

                                //progress bar

                                LinearPercentIndicator(
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  animation: true,
                                  lineHeight: 15.0,
                                  animationDuration: 2500,
                                  percent: 0.8,
                                  // linearStrokeCap: LinearStrokeCap.roundAll,
                                  barRadius: const Radius.circular(10),
                                  progressColor:
                                      const Color.fromARGB(255, 0, 255, 148),
                                ),
                                //percentage completed text
                                Text(
                                  "50% Completed",
                                  style: GoogleFonts.archivo(
                                    fontSize: 15,
                                    color: Colors.white.withOpacity(0.7),
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                  ),
                                ),

                                //complete workout button on the right end
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const MyWorkourtPage1(),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            255, 231, 254, 85),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Complete Workout",
                                            style: GoogleFonts.archivo(
                                              fontSize: 13,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          const Icon(
                                            Icons.north_east,
                                            color: Colors.black,
                                            size: 13,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  ConfettiWidget(
                    confettiController: _controllerCenter,
                    blastDirectionality: BlastDirectionality.explosive,
                    blastDirection: pi / 2,
                    maxBlastForce: 100,
                    minBlastForce: 80,
                    emissionFrequency: 0.05,
                    numberOfParticles: 50,
                    gravity: 0.2,
                  ),
                ],
              );
            })));
  }

  // Fetch the calories for the current user
  Future<int> fetchCaloriesForCurrentUser(String userId) async {
    // Get the current date
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);

    // Create a variable to store the total calories
    int totalCalories = 0;

    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('food_items').get();
      print('snapshot.docs.length: ${snapshot.docs.length}');
      // Iterate over the documents and calculate the total calories
      for (QueryDocumentSnapshot doc in snapshot.docs) {
        int calories = doc['calories'];
        setState(() {
          totalCalories += calories;
        });
      }
      print('Total calories: $totalCalories');
    } catch (e) {
      print('Error fetching calories: $e');
    }

    return totalCalories;
  }
}
