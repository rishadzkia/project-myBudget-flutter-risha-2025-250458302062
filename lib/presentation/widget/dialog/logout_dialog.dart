import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_budget/core/colors.dart';

class LogoutDialog extends StatelessWidget {
  final VoidCallback onLogout;
  const LogoutDialog({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.biru1,
      insetPadding: EdgeInsets.symmetric(horizontal: 38),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(28, 34, 28, 26),
        decoration: BoxDecoration(
          color: AppColors.biru1,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.logout_rounded,
              color: Colors.red,
              size: 45,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Keluar dari Akun?",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Anda akan keluar dari akun ini dan perlu mengakses kembali Akun ini",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  color: Color(0xFFFA7E7E),
                  fontSize: 12,
                  height: 1.5,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 34,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                onLogout();
              },
              child: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xFFFB2C36),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Ya, Keluar',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 7,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                    color: Color(0xFF1D4C78),
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                  child: Text(
                    'Batal',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
