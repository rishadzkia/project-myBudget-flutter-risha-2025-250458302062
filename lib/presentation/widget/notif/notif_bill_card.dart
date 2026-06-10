import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotifBillCard extends StatelessWidget {
  final String title;
  final String date;
  final String amount;
  final String status;
  final Color statusColor;
  final Color statusTextColor;
  final VoidCallback? onTap;

  const NotifBillCard({
    super.key,
    required this.title,
    required this.date,
    required this.amount,
    required this.status,
    required this.statusColor,
    required this.statusTextColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 78,
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(22, 12, 20, 12),
        decoration: BoxDecoration(
          color: const Color(0xFF064579),
          borderRadius: BorderRadius.circular(9),
          border: Border.all(
            color: const Color(0xFF7DC2F0),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      height: 1,
                    ),
                  ),

                  const Spacer(),

                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.white,
                        size: 16,
                      ),

                      const SizedBox(width: 5),

                      Text(
                        date,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: statusColor.withOpacity(0.55),
                        blurRadius: 12,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Text(
                    status,
                    style: GoogleFonts.poppins(
                      color: statusTextColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                const Spacer(),

                Text(
                  amount,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}