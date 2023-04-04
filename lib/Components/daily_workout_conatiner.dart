import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DailyWorkoutContainer extends StatefulWidget {
  final String imageURL;
  final String title;
  final String subtitle;
  final String buttonText;
  final bool blackContainer;
  const DailyWorkoutContainer({
    super.key,
    required this.imageURL,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.blackContainer,
  });

  @override
  State<DailyWorkoutContainer> createState() => _DailyWorkoutContainerState();
}

class _DailyWorkoutContainerState extends State<DailyWorkoutContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 10,
      decoration: BoxDecoration(
        color: widget.blackContainer? Colors.black:const Color.fromARGB(255, 231, 254, 85),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Image.asset(widget.imageURL),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    style: GoogleFonts.archivo(
                      color: widget.blackContainer? Colors.white:Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.subtitle,
                    style: GoogleFonts.archivo(
                      color:widget.blackContainer? Colors.white:Colors.black,
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
                // minimumSize: const Size(100, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor:widget.blackContainer? const Color.fromARGB(255, 231, 254, 85):Colors.black,),
              child: Row(
                children: [
                  Text(
                    widget.buttonText,
                    style: GoogleFonts.archivo(
                      color:widget.blackContainer? Colors.black:Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Icon(
                    Icons.north_east,
                    color:widget.blackContainer? Colors.black:Colors.white,
                    size: 16,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
