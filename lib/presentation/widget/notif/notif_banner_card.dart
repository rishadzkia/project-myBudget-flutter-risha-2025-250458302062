import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_budget/core/colors.dart';

class NotifBannerCard extends StatelessWidget {
  const NotifBannerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20, 16, 120, 16),
      decoration: BoxDecoration(
        color: AppColors.biru4,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: -135,
            top: -44,
            child: Image.asset(
              'assets/home_page/lonceng_bunyi.png',
              width: 130,
              height: 130,
              fit: BoxFit.contain,
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 6),
              Text(
                'Jangan Sampai Telat\n Bayar, yaa',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  height: 1.5,
                ),
              ),

              SizedBox(height: 8),

              Text(
                'Atur pengingat dan bayar tepat waktu agar\n keuanganmu tetap aman',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}