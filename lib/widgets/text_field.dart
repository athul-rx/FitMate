
import 'package:flutter/material.dart';


Widget textField(String hintText, bool isPassword, TextEditingController controller) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    decoration: BoxDecoration(
      color: Colors.grey[200],
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
      decoration: InputDecoration(
        hintText: hintText,
        border: InputBorder.none,
      ),
    ),
  );
}