import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_budget/core/colors.dart';

class CustomFloatingButton extends StatelessWidget {
  const CustomFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 120,
        height: 120,
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                      center: Alignment(-0.25, -0.35),
                      radius: 1,
                      colors: [
                        Color(0xFF5D7081),
                        Color(0xFFF001E3A),
                        Color(0xFF7CBCE8),
                      ]),
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 0,
                      offset: Offset(0, 4),
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 0,
                      offset: Offset(0, 4),
                    )
                  ]),
              child: Center(
                  child: Stack(alignment: Alignment.center, children: [
                Text(
                  '+',
                  style: GoogleFonts.poppins(
                      fontSize: 40,
                      color: Colors.white,
                      height: 1,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        )
                      ]),
                )
              ]))),
          SizedBox(height: 4),
          Text(
            'Kategori',
            style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w600,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6, 
                    offset: Offset(0, 4),
                  )
                ]),
          ),
        ]));
  }
}
