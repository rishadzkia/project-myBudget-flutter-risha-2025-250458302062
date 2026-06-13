import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TransaksiCategoryCard extends StatelessWidget {
  final String category;
  final IconData icon;
  final Color bgIcon;
  final VoidCallback? onTap;
  const TransaksiCategoryCard({
    super.key,
    required this.category,
    required this.icon,
    required this.bgIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Color(0xFF043869),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 16,
              offset: Offset(2, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: bgIcon,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white, width: 1.5),
              ),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                category,
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
