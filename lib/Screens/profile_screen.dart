import 'dart:developer';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:fitmate/Models/bimetric_response.dart';
import 'package:fitmate/services/api_services.dart';
import 'package:fitmate/widgets/DropDownField.dart';
import 'package:fitmate/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _dobController = TextEditingController(text: "20");
  final _genderController = TextEditingController(text: "Male");

  final _heightController = TextEditingController(text: "170");
  final _bmiController = TextEditingController(text: "170");

  final _weightController = TextEditingController(text: "60");

  String name = "user";

  void getname() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString('name');
    name = name!;
  }

  List<String> genderValue = ["Male", "Female"];

  @override
  void initState() {
    super.initState();
    getData();
  }

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
        body: FutureBuilder(
            future: Future.delayed(
                const Duration(seconds: 5)), // Delay of 5 seconds
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Show a loading indicator while waiting for the delay to complete
                return Container(
                  width: double.infinity,
                  // height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                );
              } else {
                return SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    // height: MediaQuery.of(context).size.height * 1.2,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28, vertical: 10),
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
                                      backgroundColor:
                                          Color.fromARGB(255, 0, 255, 148),
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
                                name,
                                style: GoogleFonts.archivo(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 50),
                              Padding(
                                padding: const EdgeInsets.only(left: 25),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Icon(
                                      Icons.fire_extinguisher_outlined,
                                      color: Colors.white,
                                    ),
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
                                            fontSize: 12,
                                            fontWeight: FontWeight.w200,
                                          ),
                                        ),
                                      ],
                                    ),
                                    // const SizedBox(width: 35),
                                    SizedBox(
                                      width: 1,
                                      height: 35,
                                      child: Container(
                                        color: const Color.fromARGB(
                                            255, 110, 109, 109),
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
                                            fontSize: 12,
                                            fontWeight: FontWeight.w200,
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
                          // height: MediaQuery.of(context).size.height / 2,
                          padding: const EdgeInsets.only(right: 20),
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
                                const SizedBox(height: 10),

                                const SizedBox(height: 20),

                                // DatePickerFormField(controller: _dobController),
                                DateTimePicker(
                                  initialValue: '',
                                  // controller: _dobController,
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.white),
                                  type: DateTimePickerType.date,

                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                  dateLabelText: 'Date of Birth',
                                  onChanged: (val) => print(val),
                                  autocorrect: true,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Date of Birth',
                                    labelStyle: TextStyle(color: Colors.white),
                                    suffixIcon: Icon(
                                      Icons.calendar_today,
                                      color: Colors.white,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  validator: (val) {
                                    print(val);
                                    return null;
                                  },
                                  onSaved: (val) => print(val),
                                ),
                                const SizedBox(height: 20),

                                DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors
                                              .white), // Set the border color to white
                                      borderRadius: BorderRadius.circular(
                                          4), // Optional: Set border radius for a rounded border
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors
                                              .white), // Set the focused border color to white
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    hintStyle: TextStyle(
                                        color: Colors
                                            .white), // Set the hint text color to white
                                  ),
                                  value: _genderController.text,
                                  items: ["Male", "Female"]
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Container(
                                        color: value == _genderController.text
                                            ? Colors.black
                                            : null, // Set background color to black for selected item
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                            color: value ==
                                                    _genderController.text
                                                ? Colors.white
                                                : Colors
                                                    .black, // Set text color to white for selected item
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  hint: Text(
                                    "Gender",
                                    style: TextStyle(
                                        color: Colors
                                            .white), // Set the hint text color to white
                                  ),
                                  onChanged: (value) {
                                    _genderController.text = value!;
                                  },
                                ),

                                const SizedBox(height: 20),
                                textField(
                                    "Weight", false, _weightController, true),
                                const SizedBox(height: 20),
                                textField(
                                    "Height", false, _heightController, true),
                                const SizedBox(height: 10),
                                textField("BMI", false, _bmiController, true),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
            }));
  }

  void getData() async {
    try {
      BiometricResponse res = await APIServices().fetchUserBiometric();
      setState(() {
        _heightController.text = res.data!.height.toString();
        _weightController.text = res.data!.weight.toString();
        _bmiController.text = res.data!.bmi.toString();
        log(res.data!.height.toString());
      });
    } catch (error) {
      log(error.toString());
    }
  }
}
