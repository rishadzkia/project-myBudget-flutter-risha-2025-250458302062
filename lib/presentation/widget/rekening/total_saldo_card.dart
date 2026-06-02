import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_budget/core/colors.dart';

class TotalSaldoCard extends StatelessWidget {
  final String title;
  final String nominal;
  const TotalSaldoCard({super.key, required this.title, required this.nominal});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 26, vertical: 20),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  AppColors.biru1,
                  AppColors.biru2,
                  Color(0xFF094985),
                  Color(0xFF1273CE),
                ]),
            border: Border.all(color: Color(0xFF65BDFE), width: 1.5),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 6,
                offset: Offset(0, 3),
              )
            ]),
        child: Column(children: [
          Text(title,
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700)),
          SizedBox(height: 10),
          Text(nominal,
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700)),
        ]));
  }
}
