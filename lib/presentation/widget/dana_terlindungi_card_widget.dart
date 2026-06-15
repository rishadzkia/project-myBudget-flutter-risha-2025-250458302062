import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DanaTerlindungiCardWidget extends StatelessWidget {
  final String jumlah;
  final VoidCallback? onTap;
  final String text;
  const DanaTerlindungiCardWidget(
      {super.key, required this.jumlah, this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        height: 215,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/home_page/bg_total.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
                right: 3,
                bottom: 28,
                child: Image.asset(
                  'assets/home_page/harta_karun.png',
                  width: 160,
                  height: 160,
                  fit: BoxFit.cover,
                )),
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(16, 22, 130, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ImageIcon(AssetImage('assets/home_page/shield.png')),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                          child: Text(
                        'Dana Terlindungi',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    jumlah,
                    maxLines: 1,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 27,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    'Dana ini sudah di sisihkan\ndan tidak dapat di gunakan',
                    maxLines: 2,
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 10,
                        height: 1.2,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 22,
                  ),

                  // Button
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onTap,
                      borderRadius: BorderRadius.circular(12),
                      child: Ink(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                            color: Color(0xFF082F6E).withOpacity(0.5),
                            border: Border.all(
                                color: Colors.white.withOpacity(0.18)),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 10,
                                  offset: Offset(0, 8))
                            ]),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Lihat Dana',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                              size: 10,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
