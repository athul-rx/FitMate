import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class MyWorkoutPage2 extends StatefulWidget {
  const MyWorkoutPage2({super.key});

  @override
  State<MyWorkoutPage2> createState() => _MyWorkoutPage2State();
}

class _MyWorkoutPage2State extends State<MyWorkoutPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
              "Arm Workout",
              style: GoogleFonts.archivo(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 231, 254, 85),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                     Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 4,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 12, 12, 12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 30, right: 30, bottom: 15, top: 5),
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
                            width: MediaQuery.of(context).size.width - 150,
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
                  const SizedBox(height: 20,),
                  Center(
                    child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Ever since the 1500s",textAlign: TextAlign.center, style: GoogleFonts.archivo(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      
                    ),),
                  ),
                  Row(
                    children: const [
                      // Image.asset("images/arm.png"),
                      // const SizedBox(width: 10,),
                      // Image.asset("images/arm2.png")
                    ],
                  )
                  
                  ],
                ),
              ),

            )
            ],
          ),
      )
    );
  }
}