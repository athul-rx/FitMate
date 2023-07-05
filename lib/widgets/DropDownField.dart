// ignore_for_file: file_names

import 'package:flutter/material.dart';

class DropdownField extends StatefulWidget {
  final List<String> dropdownValues;
  final String hintText;
  final Function(String) onChanged;
  final TextEditingController controller;
  const DropdownField(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.onChanged,
      required this.dropdownValues});
  @override
  // ignore: library_private_types_in_public_api
  _DropdownFieldState createState() => _DropdownFieldState();
}

class _DropdownFieldState extends State<DropdownField> {
  String? _selectedOption; // this variable will hold the selected option
  List<DropdownMenuItem> _dropdownMenuItems = [];

  // create a list of options
  @override
  initState() {
    super.initState();
    // _selectedOption = widget.controller.text;
    _dropdownMenuItems = widget.dropdownValues.map((option) {
      return DropdownMenuItem(
        value: option,
        child: Text(option),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      isExpanded: true,
      style: const TextStyle(color: Colors.white),
      dropdownColor: Colors.black,
      hint: Text(widget.hintText, style: const TextStyle(color: Colors.white),),
      focusColor: Colors.grey,
      value: _selectedOption, // set the selected option
      items: _dropdownMenuItems,
      decoration: const InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.all(
              Radius.circular(30)
          )
        ),
        focusColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.all(
              Radius.circular(30)
          )
        ),
       filled: true, 
        fillColor: Colors.black
      ),
      onChanged: (newValue) {
        setState(() {
          _selectedOption = newValue;
          widget.controller.text = _selectedOption!;
          // widget.onChanged(newValue!);
        });
      },
      // decoration: const InputDecoration(
      //     // labelText: 'Select a product' ,

      //     border: OutlineInputBorder(),
      //     focusedBorder: InputBorder.none),
    );
  }

  // @override
  // void dispose() {
  //   widget.controller.dispose();
  //   super.dispose();
  // }
}
