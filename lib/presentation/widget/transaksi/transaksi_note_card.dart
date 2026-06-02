import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TransaksiNoteCard extends StatelessWidget {
  final TextEditingController controller;
  final IconData? icon;
  final String? label;

  const TransaksiNoteCard(
      {super.key, required this.controller, this.icon, this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label ?? '',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 56,
          decoration: BoxDecoration(
            color: const Color(0xFF064577),
            borderRadius: BorderRadius.circular(9),
          ),
          child: TextField(
            controller: controller,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
            cursorColor: Colors.white,
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                size: 22,
                color: Colors.white,
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 17),
            ),
          ),
        )
      ],
    );
  }
}
