import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotifInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? suffixIcon;
  final bool readOnly;
  final VoidCallback? onTap;

  const NotifInput(
      {super.key,
      required this.controller,
      required this.hintText,
      this.suffixIcon,
      required this.readOnly,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      cursorColor: Colors.black,
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
          color: const Color(0xFF8E8E8E),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        suffixIcon: suffixIcon == null
            ? null
            : Icon(
                suffixIcon,
                color: Colors.black,
                size: 28,
              ),
        filled: true,
        fillColor: const Color(0xFFF7F7F7),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 18,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Color(0xFFD9D9D9),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Color(0xFF1672B4),
            width: 1.2,
          ),
        ),
      ),
    );
  }
}
