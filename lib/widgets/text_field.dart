
import 'package:flutter/material.dart';


Widget textField(String hintText, bool isPassword, TextEditingController controller, [bool isProfile = false]) {
  return Container(
    decoration: BoxDecoration(
      color: isProfile ? Colors.black : Colors.white,
      borderRadius: BorderRadius.circular(5),
    ),
    child: TextFormField(
      controller: controller,
      obscureText: isPassword,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter some text';
        }
        else if(isPassword && value.length < 8){
          return 'Password must be at least 8 characters';
        }
        return null;
      },
      style: TextStyle(
        color: isProfile ? Colors.white : Colors.black,
      ),
      
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isProfile ? Colors.white : Colors.black,
          ),
        ),
        

        hintText: hintText,
        hintStyle: TextStyle(
          color: isProfile ? Colors.white : Colors.black,
        ),
        focusColor: isProfile ? Colors.white : Colors.black,
        // filled: true, 
        // fillColor: Color.fromARGB(0, 255, 255, 255)
      ),
    ),
  );
}