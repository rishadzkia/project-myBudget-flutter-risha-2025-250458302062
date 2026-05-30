import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_budget/core/colors.dart';

class MaskotButtonNav extends StatelessWidget {
  final bool isActive;
  final VoidCallback onTap;
  const MaskotButtonNav(
      {super.key, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final Color activeColor = AppColors.biru2;
    final Color inactiveColor = Colors.grey;

    return GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
            width: 64,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(
                'assets/maskot/main_mascot.png',
                width: 24,
                height: 24,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 4),
              Text('Level',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    color: isActive ? activeColor : inactiveColor,
                    fontSize: 12,
                    fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                  ))
            ])));
  }
}
