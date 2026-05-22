import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TotalSaldoMainWidget extends StatelessWidget {
  final String saldo;
  const TotalSaldoMainWidget({super.key, required this.saldo});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(20, 20, 130, 20),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/home_page/bg_total.png'),
                fit: BoxFit.cover)),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TOTAL SALDO',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, fontSize: 16),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  saldo,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, fontSize: 28),
                )
              ],
            ),
            Positioned(
                right: -150,
                bottom: -45,
                child: Opacity(
                  opacity: 0.25,
                  child: Image.asset(
                    'assets/home_page/pot.png',
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
