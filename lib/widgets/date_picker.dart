import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class DatePickerFormField extends StatefulWidget {
  final TextEditingController controller;

  const DatePickerFormField({Key? key, required this.controller}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DatePickerFormFieldState createState() => _DatePickerFormFieldState();
}

class _DatePickerFormFieldState extends State<DatePickerFormField> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
        widget.controller.text = formattedDate;
      });
    } else if (picked == null) {
      setState(() {
        _selectedDate = DateTime.now();
        final formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
        widget.controller.text = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => _selectDate(context),
          child: AbsorbPointer(
            child: Theme(
              data: ThemeData(
                colorScheme: const ColorScheme.dark(
                  primary: Colors.white, // set the underline border color
                  surface: Colors.black, // set the background color
                ),
                textSelectionTheme: const TextSelectionThemeData(
                  cursorColor: Colors.white,
                ),
              ),
              child: TextFormField(
                controller: widget.controller,
                decoration: InputDecoration(
                  labelText: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                  hintText: 'Select Date',
                  border: const UnderlineInputBorder(),
                   // remove the default border
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
