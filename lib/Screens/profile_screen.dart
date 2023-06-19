import 'package:fitmate/widgets/DropDownField.dart';
import 'package:fitmate/widgets/date_picker.dart';
import 'package:fitmate/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final _dobController = TextEditingController();
  final _genderController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  List<String> genderValue = ["Male", "Female"];
  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Profile",
                  style: GoogleFonts.archivo(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  // height: MediaQuery.of(context).size.height / 3.4,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 12, 12, 12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Stack(
                        alignment: Alignment.center,
                        children: const [
                          SizedBox(
                            height: 120,
                            width: 120,
                            child: CircularProgressIndicator(
                              value: 0,
                              strokeWidth: 6,
                              backgroundColor: Color.fromARGB(255, 0, 255, 148),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color.fromARGB(255, 75, 72, 72)),
                            ),
                          ),
                          CircleAvatar(
                            radius: 60,
                            backgroundImage:
                                AssetImage('assets/images/profile.jpg'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "John Doe",
                        style: GoogleFonts.archivo(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset("assets/images/steps.png"),
                            // const SizedBox(width: 20),

                            Column(
                              children: [
                                Text(
                                  "1200",
                                  style: GoogleFonts.archivo(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "Calories",
                                  style: GoogleFonts.archivo(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            // const SizedBox(width: 35),
                            SizedBox(
                              width: 1,
                              height: 35,
                              child: Container(
                                color: const Color.fromARGB(255, 110, 109, 109),
                              ),
                            ),
                            Image.asset("assets/images/steps.png"),
                            // const SizedBox(width: 20),

                            Column(
                              children: [
                                Text(
                                  "1200",
                                  style: GoogleFonts.archivo(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "Daily Goal",
                                  style: GoogleFonts.archivo(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 2.5,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 12, 12, 12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, top: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Date of Birth",
                          style: GoogleFonts.archivo(
                            color: const Color.fromARGB(255, 246, 246, 246),
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 5),
                        // Expanded(child: DatePickerFormField(controller: _dobController)),
                        const SizedBox(height: 10),
                        Text(
                          "Daily Goal",
                          style: GoogleFonts.archivo(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        // Expanded(
                        //   child: DropdownField(
                        //       hintText: "Food/Drink",
                        //       controller: _genderController,
                        //       onChanged: (newValue) {},
                        //       dropdownValues: genderValue),
                        // ),

                        const SizedBox(height: 10),
                        textField("Weight", false, _weightController),
                        const SizedBox(height: 10),
                        textField("Height", false, _heightController),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
