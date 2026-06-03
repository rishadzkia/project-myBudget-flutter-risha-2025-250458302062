import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_budget/core/colors.dart';

class RekeningListCard extends StatelessWidget {
  final IconData icon;
  final Color bgColor;
  final String title;
  final String nominal;
  final VoidCallback? onTap;
  final VoidCallback? onDeleteTap;
  const RekeningListCard(
      {super.key,
      required this.icon,
      required this.bgColor,
      required this.title,
      required this.nominal,
      this.onTap,
      this.onDeleteTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
            height: 60,
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(14, 9, 18, 9),
            decoration: BoxDecoration(
              color: AppColors.biru2,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(children: [
              GestureDetector(
                  onTap: onDeleteTap,
                  child: Icon(Icons.remove_circle_outline,
                      color: Color(0xFFFF0000), size: 20)),
              SizedBox(width: 12),
              Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                  child: Icon(icon, color: Colors.white, size: 20)),
              SizedBox(width: 12),
              Expanded(
                child: Text(title,
                    maxLines: 1,
                    // TextOverflow.ellipsis
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    )),
              ),
              Text(nominal,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ))
            ])));
  }
}
