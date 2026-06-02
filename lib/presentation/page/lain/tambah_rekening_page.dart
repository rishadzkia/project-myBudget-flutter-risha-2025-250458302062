import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_budget/core/colors.dart';
import 'package:my_budget/presentation/widget/rekening/button_rekening.dart';
import 'package:my_budget/presentation/widget/rekening/simbol_card.dart';
import 'package:my_budget/presentation/widget/transaksi/transaksi_note_card.dart';

class TambahRekeningPage extends StatefulWidget {
  const TambahRekeningPage({super.key});

  @override
  State<TambahRekeningPage> createState() => _TambahRekeningPageState();
}

class _TambahRekeningPageState extends State<TambahRekeningPage> {
  final TextEditingController namaRekening = TextEditingController();
  final TextEditingController catatanController = TextEditingController();
  final TextEditingController nominalController = TextEditingController();

// Terpilih satu simbol
  int selectedSymbol = 0;

  @override
  void dispose() {
    namaRekening.dispose();
    catatanController.dispose();
    nominalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.biru1,
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              'Tambah Rekening',
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
              ),
            ),
            SafeArea(
                child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
              padding: EdgeInsets.fromLTRB(20, 50, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Untuk card tambah nominal
                  Container(
                      height: 140,
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 26, vertical: 20),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                AppColors.biru1,
                                AppColors.biru2,
                                Color(0xFF094985),
                                Color(0xFF1273CE),
                              ]),
                          border:
                              Border.all(color: Color(0xFF65BDFE), width: 1.5),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            )
                          ]),
                      child: Column(children: [
                        Text('Input Nominal',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700)),
                        SizedBox(height: 10),
                        TextField(
                            controller: nominalController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: 'Masukkan nominal...',
                                hintStyle: GoogleFonts.poppins(
                                    color: Colors.grey[200]),
                                border: InputBorder.none,
                                prefixText: 'Rp ',
                                prefixStyle: GoogleFonts.poppins(
                                    color: Colors.grey[200],
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600)),
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w600))
                      ])),
                  // end card tambah nominal

                  SizedBox(height: 28),
                  Text(
                    'Simbol Rekening',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SimbolCard(
                        icon: Icons.money_off_rounded,
                        bgIcon: Colors.redAccent,
                        isSelected: selectedSymbol == 0,
                        onTap: () {
                          setState(() {
                            selectedSymbol = 0;
                          });
                        },
                      ),
                      SizedBox(width: 4),
                      SimbolCard(
                        icon: Icons.account_balance_rounded,
                        bgIcon: Colors.blueAccent,
                        isSelected: selectedSymbol == 1,
                        onTap: () {
                          setState(() {
                            selectedSymbol = 1;
                          });
                        },
                      ),
                      SizedBox(width: 4),
                      SimbolCard(
                        icon: Icons.account_balance_rounded,
                        bgIcon: Colors.blueAccent,
                        isSelected: selectedSymbol == 1,
                        onTap: () {
                          setState(() {
                            selectedSymbol = 1;
                          });
                        },
                      ),
                      SizedBox(width: 4),
                      SimbolCard(
                        icon: Icons.account_balance_rounded,
                        bgIcon: Colors.blueAccent,
                        isSelected: selectedSymbol == 1,
                        onTap: () {
                          setState(() {
                            selectedSymbol = 1;
                          });
                        },
                      ),
                      SizedBox(width: 4),
                      SimbolCard(
                        icon: Icons.account_balance_rounded,
                        bgIcon: Colors.blueAccent,
                        isSelected: selectedSymbol == 1,
                        onTap: () {
                          setState(() {
                            selectedSymbol = 1;
                          });
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: 12),
                  TransaksiNoteCard(
                      controller: namaRekening, label: 'Nama Rekening'),
                  SizedBox(height: 10),
                  TransaksiNoteCard(controller: namaRekening, label: 'Catatan'),
                  SizedBox(height: 20),
                  ButtonRekening(title: 'Simpan Rekening', onTap: () {})
                ],
              ),
            ))
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
