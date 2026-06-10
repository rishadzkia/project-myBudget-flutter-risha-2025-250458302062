import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_budget/core/colors.dart';

class TagihanNotifDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final String totalTagihan;
  final String date;
  final VoidCallback onDetailTap;
  final String icon;
  const TagihanNotifDialog(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.totalTagihan,
      required this.date,
      required this.onDetailTap,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(horizontal: 40),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(22, 34, 22, 22),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 12,
                      offset: Offset(0, 4))
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Image.asset(
                      'assets/icons/icon_calemder.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      color: AppColors.biru1,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  '$subtitle {$date}',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      color: const Color.fromARGB(255, 57, 60, 62),
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 26,
                ),
                Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD7EADF),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.wifi_rounded,
                        color: Color(0xFF209EF2),
                        size: 34,
                      ),
                      const SizedBox(width: 14),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total tagihan',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              height: 1.1,
                            ),
                          ),
                          Text(
                            totalTagihan,
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                GestureDetector(
                  onTap: onDetailTap,
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: double.infinity,
                    height: 38,
                    decoration: BoxDecoration(
                      color: const Color(0xFF006D34),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF006D34).withOpacity(0.22),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Lihat Detail',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: -7,
            right: -5,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: const Color(0xFFEDEDED),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF8A8A8A),
                    width: 1.3,
                  ),
                ),
                child: const Icon(
                  Icons.close_rounded,
                  color: Color(0xFF8A8A8A),
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
