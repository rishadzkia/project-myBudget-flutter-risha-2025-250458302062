import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterTanggalCard extends StatelessWidget {
  const FilterTanggalCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF064579),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          'Filter Tanggal',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
