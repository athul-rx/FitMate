import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Button extends StatefulWidget {
  final String text;
  final Widget route;
  const Button({super.key, required this.text,required this.route});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      height: 50,
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => widget.route));
      },
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.text,
            
            style: GoogleFonts.archivo(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 15),
          const Icon(
            Icons.arrow_forward,
            color: Colors.black,
            size: 16,
          ),
        ],
      ),
    );
  }
}
