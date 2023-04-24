
// ignore_for_file: depend_on_referenced_packages

import 'package:fitmate/widgets/bar_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat("EEEE,d MMMM").format(now);
    // final num steps;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 21, 21, 21),
          elevation: 0,
          actions: [
            Image.asset(
              'assets/images/logo1.png',
              width: 50,
              height: 50,
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 10),
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
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 12, 12, 12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    formattedDate,
                    style: GoogleFonts.archivo(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "You have completed 0 workouts",
                    style: GoogleFonts.archivo(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 30,),
                  SizedBox(
                              height: 120, width: 200, child: BarChartWidget(showtitle: false,)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 8,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 12, 12, 12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.start,
            
                  children: [
                    Image.asset("assets/images/feat.png"),
                    Padding(
                      padding: const EdgeInsets.only( left: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Your Daily Goal",
                            style: GoogleFonts.archivo(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "0/0",
                            style: GoogleFonts.archivo(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor:
                              const Color.fromARGB(255, 231, 254, 85)),
                      child: Row(
                        children: [
                          Text(
                            "Set Goal",
                            style: GoogleFonts.archivo(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 15),
                          const Icon(
                            Icons.north_east,
                            color: Colors.black,
                            size: 16,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            historySteps(1000),
            
            const Padding(
              padding: EdgeInsets.only(left: 25, right: 10),
              child: Divider(color: Colors.white,height: 50,),
            ),
            
            historySteps(1000),
            
            const Padding(
              padding: EdgeInsets.only(left: 25, right: 10),
              child: Divider(color: Colors.white,height: 50,),
            ),
            historySteps(200),
             const Padding(
              padding: EdgeInsets.only(left: 25, right: 10),
              child: Divider(color: Colors.white,height: 50,),
            ),
            
          ],
              ),
            ),
        ));
  }

  Widget historySteps(num steps) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat("EEEE,d MMMM").format(now);
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 10,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        
        children: [
          Image.asset("assets/images/steps.png"),
          const SizedBox(width: 10),
          Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                formattedDate,
                style: GoogleFonts.archivo(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "$steps Steps",
                style: GoogleFonts.archivo(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            //  const SizedBox(height: 10),
            // const Divider(color: Colors.white,height: 50,)
            ],
          )
        ],
      ),
    );
  }
}
