import 'dart:developer';

import 'package:fitmate/Models/calories_response.dart';
import 'package:fitmate/services/food_calories.dart';
import 'package:fitmate/widgets/DropDownField.dart';
import 'package:fitmate/widgets/ElevatedButton.dart';
import 'package:fitmate/widgets/Table.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyNutrition extends StatefulWidget {
  const MyNutrition({super.key});

  @override
  State<MyNutrition> createState() => _MyNutritionState();
}

List<String> _food = [
  "Rice",
  "Oats",
  "Bread",
  "Pasta",
  "Noodles",
  "Potato",
  "Appam",
  "Tea",
  "Coffee",
  "Brisket"
];
double? calories;
double? finalCalories;
List<String> meals = ["Breakfast", "Lunch", "Dinner", "Snacks"];
List<String> quantity = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
final List<Map<String, dynamic>> items = [
  {'name': 'Item 1', 'quantity': 5, 'size': 'Small'},
  {'name': 'Item 2', 'quantity': 10, 'size': 'Medium'},
  {'name': 'Item 3', 'quantity': 3, 'size': 'Large'},
  {'name': 'Item 4', 'quantity': 7, 'size': 'Extra Large'},
];

TextEditingController _mealsController = TextEditingController();
TextEditingController _foodController = TextEditingController();
TextEditingController _quantityController = TextEditingController();
TextEditingController _gramController = TextEditingController();

void fetchData() {
  ApiServices()
      .fetchNutritionData("rice")
      .then((List<CaloriesResponseModel> res) {
    log("${res[0].calories} res");
  }).catchError((error) {
    log(error);
  });
}

class _MyNutritionState extends State<MyNutrition> {
  @override
  Widget build(BuildContext context) {
    // fetchData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 21, 21, 21),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            children: [
              Text(
                "Nutrition",
                style: GoogleFonts.archivo(
                  color: Colors.white,
                  fontSize: 30,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w500,
                ),
              ),

              //first container
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 4,
                padding: const EdgeInsets.only(left: 3),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 21, 21, 21),
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "John's Diet Plan",
                            style: GoogleFonts.archivo(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),

                          //horizontal line
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            width: MediaQuery.of(context).size.width / 2.5,
                            height: 1,
                            color: Colors.white.withOpacity(0.7),
                            margin: const EdgeInsets.symmetric(vertical: 10),
                          ),
                          Text(
                            "1950 Cal | South Indian",
                            style: GoogleFonts.archivo(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          SizedBox(
                            width: 120,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 231, 254, 85),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "Continue",
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
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 170,
                        height: MediaQuery.of(context).size.height / 3.3,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/food_image.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //paragraph

              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "Lets gather your preferences and create a plan to help you achieve your goal!",
                  style: GoogleFonts.archivo(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.5,
                  ),
                ),
              ),

              const SizedBox(height: 20),
              //create new diet plan
              button("CREATE NEW DIET PLAN"),
              const SizedBox(
                height: 40,
              ),

              Text(
                "Calories Counter",
                style: GoogleFonts.archivo(
                  color: Colors.white,
                  fontSize: 30,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w500,
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "Food Calorie Counter below allows you to choose from thousands of foods and brands, and see nutrition facts. Get started by entering your food and drink choices",
                  style: GoogleFonts.archivo(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.5,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Column(
                children: [
                  Center(
                    child: Text(
                      "ITEM 1",
                      style: GoogleFonts.archivo(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 15,
                          letterSpacing: 1.5),
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownField(
                      hintText: "BreakFast/Lunch/Dinner",
                      controller: _mealsController,
                      onChanged: (newValue) {
                        setState(() {
                          _mealsController.text = newValue;
                        });
                      },
                      dropdownValues: meals),
                  const SizedBox(height: 20),
                  DropdownField(
                      hintText: "Select the food item",
                      controller: _foodController,
                      onChanged: (newValue) {
                        setState(() {
                          _foodController.text = newValue;
                        });
                      },
                      dropdownValues: _food),
                  const SizedBox(height: 20),
                  // DropdownField(
                  //     hintText: "Enter the Item",
                  //     controller: _dropdowncontroller,
                  //     onChanged: (newValue) {
                  //       setState(() {
                  //         _dropdowncontroller.text = newValue!;
                  //       });

                  //     },
                  //     dropdownValues: _food),
                  // const SizedBox(height: 20),
                  DropdownField(
                    hintText: "Enter the serving size in grams",
                    controller: _gramController,
                    onChanged: (newValue) {
                      setState(() {
                        _gramController.text = newValue;
                      });
                    },
                    dropdownValues: _food,
                  ),
                  const SizedBox(height: 20),
                  DropdownField(
                      hintText: "Select Quantity",
                      controller: _quantityController,
                      onChanged: (newValue) {
                        setState(() {
                          _quantityController.text = newValue;
                        });
                      },
                      dropdownValues: quantity),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  ApiServices()
                      .fetchNutritionData(
                    _foodController.text,
                  )
                      .then((List<CaloriesResponseModel> res) {
                    calories = res[0].calories;
                    log("${res[0].calories} res");
                  }).catchError((error) {
                    log(error);
                  });

                  setState(() {
                    finalCalories = _quantityController.text.isEmpty
                        ? calories
                        : calories! * double.parse(_quantityController.text);
                  });
                  log(finalCalories.toString());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 231, 254, 85),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        "CALCULATE CALORIES COUNT",
                        style: GoogleFonts.archivo(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          // letterSpacing: 1,
                        ),
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
              const SizedBox(
                height: 30,
              ),

              Text(
                "Calories Counter",
                style: GoogleFonts.archivo(
                  color: Colors.white,
                  fontSize: 20,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              MyTable(
                data: items,
              )
            ],
          ),
        ),
      ),
    );
  }
}
