import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_budget/core/colors.dart';
import 'package:my_budget/presentation/widget/dialog/dana_terlindungi_dialog.dart';

class DanaTerlindungiPage extends StatefulWidget {
  const DanaTerlindungiPage({super.key});

  @override
  State<DanaTerlindungiPage> createState() => _DanaTerlindungiPageState();
}

class _DanaTerlindungiPageState extends State<DanaTerlindungiPage> {
  final TextEditingController nominalController = TextEditingController();

  String totalDana = '0';

  @override
  void dispose() {
    nominalController.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.biru1,
        body: Stack(children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.biru1,
                    AppColors.biru2,
                    AppColors.biru3,
                  ]),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _BackButton(
                      onTap: () {
                        // Ini cuman balik atau menghapus halaman sebelumnya aja
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      height: 48,
                    ),
                    Center(
                      child: Column(
                        children: [
                          Row(mainAxisSize: MainAxisSize.min, children: [
                            Image.asset(
                              'assets/home_page/shield.png',
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text('Dana Terlindungi',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: Colors.white)),
                          ]),
                          SizedBox(
                            height: 12,
                          ),
                          Text('Aman, terkunci, dan hanya untuk tujuanmu',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.white,
                              )),
                          SizedBox(
                            height: 24,
                          ),
                          Image.asset(
                            'assets/home_page/harta_karun.png',
                            width: 280,
                            height: 280,
                            fit: BoxFit.contain,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 14),
                    Text('Total Dana Terkunci',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white,
                        )),
                    SizedBox(height: 4),
                    Text('Rp. $totalDana',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: Colors.white,
                        )),
                    SizedBox(height: 6),
                    Text(
                        'Dana ini tidak dapat digunakan\nuntuk transaksi harian',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          height: 1.5,
                          color: Colors.white,
                        )),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        // Ini biar tiap klik nominalnya dikosongin
                        nominalController.clear();
                        showDialog(
                            context: context,
                            builder: (context) {
                              return DanaTerlindungiDialog(
                                  nominalController: nominalController,
                                  onSimpan: () {
                                    if (nominalController.text.isEmpty) {
                                      return;
                                    }

                                    setState(() {
                                      totalDana = nominalController.text;
                                    });

                                    Navigator.pop(context);
                                  });
                            });
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        width: double.infinity,
                        height: 48,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                                width: 1.5),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(7, 162, 152, 152)
                                    .withOpacity(0.25),
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              )
                            ]),
                        child: Center(
                          child: Text('+ Dana Terlindungi',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                  ]),
            ),
          )
        ]));
  }
}

class _BackButton extends StatelessWidget {
  final VoidCallback? onTap;

  const _BackButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.12),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
          ),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 18,
          )),
    );
  }
}
