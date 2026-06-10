import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const ProfileButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 255,
        height: 48,
        decoration: BoxDecoration(
          color: const Color(0xFF74B3DD),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
} 