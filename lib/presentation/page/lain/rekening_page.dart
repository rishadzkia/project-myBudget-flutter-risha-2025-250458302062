import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_budget/core/colors.dart';
import 'package:my_budget/presentation/page/lain/tambah_rekening_page.dart';
import 'package:my_budget/presentation/widget/rekening/button_rekening.dart';
import 'package:my_budget/presentation/widget/rekening/rekening_card.dart';
import 'package:my_budget/presentation/widget/rekening/total_saldo_card.dart';

class RekeningPage extends StatelessWidget {
  const RekeningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.biru1,
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              'Rekening',
              style: GoogleFonts.poppins(
                  color: AppColors.biru1,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            leading: GestureDetector(
                onTap: () {
                  // nge back. Buat balik ke halaman sebelumnya atau nutup alert dialog
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: AppColors.biru1,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ))),
        body: Stack(
          children: [
            ClipPath(
                clipper: HeaderClipper(),
                child: Container(
                  height: 165,
                  width: double.infinity,
                  color: AppColors.button2Color,
                )),

            // Biar page responsif, bisa di scroll kalau widget nya banyak
            SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20, 58, 20, 40),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TotalSaldoCard(
                        title: 'TOTAL SALDO', nominal: 'Rp 12.000.000'),
                    SizedBox(height: 32),
                    Text(
                      'Rekening Virtual',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 16),
                    RekeningListCard(
                        icon: Icons.attach_money_rounded,
                        bgColor: AppColors.biru4,
                        title: 'M-Banking BSI',
                        nominal: 'Rp 5.000.000'),
                    SizedBox(height: 16),
                    RekeningListCard(
                        icon: Icons.attach_money_rounded,
                        bgColor: AppColors.biru4,
                        title: 'M-Banking BRI',
                        nominal: 'Rp 5.000.000'),
                    SizedBox(height: 16),
                    RekeningListCard(
                        icon: Icons.attach_money_rounded,
                        bgColor: AppColors.biru4,
                        title: 'M-Banking BNI',
                        nominal: 'Rp 5.000.000'),
                    SizedBox(height: 24),
                    Text(
                      'Uang Tunai',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 10),
                    RekeningListCard(
                        icon: Icons.attach_money_rounded,
                        bgColor: AppColors.biru4,
                        title: 'Bank Jago',
                        nominal: 'Rp 5.000.000'),
                    SizedBox(height: 56),
                    ButtonRekening(
                        title: 'Tambah Rekening',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => TambahRekeningPage()));
                        })
                  ]),
            )
          ],
        ));
  }
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0, size.height * 0.72);

    path.quadraticBezierTo(
      size.width * 0.50,
      size.height * 1.15,
      size.width,
      size.height * 0.72,
    );

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
