import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_budget/core/colors.dart';

class ButtonRekening extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const ButtonRekening({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
            width: double.infinity,
            height: 55,
            decoration: BoxDecoration(
              color: AppColors.button2Color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
                child: Text(title,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    )))));
  }
}
