import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_budget/core/colors.dart';

class SuksesDialogRegister extends StatelessWidget {
  final VoidCallback? onPressed;
  const SuksesDialogRegister({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(28, 34, 28, 26),
        decoration: BoxDecoration(
          color: Color(0xFFFB2C36),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: AppColors.button2Color,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_rounded,
              color: Colors.white,
              size: 35,
            ),
          ),
          SizedBox(height: 14,),
          Text(
            "Akun kamu berhail dibuat.\n Silakan login untuk masuk ke MyBudget",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: Color(0xFFB7DFFF),
              fontSize: 12,
              height: 1.5,
              fontWeight: FontWeight.w500
            ),
          ),
          SizedBox(height: 30,),
          GestureDetector(
            onTap: onPressed,
            child: Container(
              width: double.infinity,
              height: 42,
              decoration: BoxDecoration(
                color: Color(0xFF2697E8),
                borderRadius: BorderRadius.circular(12)
              
              ),
              child: Center(
                child: Text("Login Sekarang",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600
                ),),
              ),
            ),
          )
          ],
          
        ),
      ),
    );
  }
}
