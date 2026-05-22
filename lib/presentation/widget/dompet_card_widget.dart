import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DompetCardWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final VoidCallback onTap;
  final String imageButton;
  const DompetCardWidget(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.onTap,
      required this.imageButton});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white, 
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3)),
          ]),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            width: 60,
            height: 60, 
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          GestureDetector( 
            onTap: onTap,
            child: Container( 
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.blueAccent, shape: BoxShape.circle),
              child: Center(
                child: Image.asset(
                  imageButton,
                  width: 20,
                  height: 20,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
