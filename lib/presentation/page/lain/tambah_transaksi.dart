import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_budget/core/colors.dart';
import 'package:my_budget/presentation/widget/rekening/button_rekening.dart';
import 'package:my_budget/presentation/widget/transaksi/transaksi_amount_card.dart';
import 'package:my_budget/presentation/widget/transaksi/transaksi_category_card.dart';

import 'package:my_budget/presentation/widget/transaksi/transaksi_info_card.dart';
import 'package:my_budget/presentation/widget/transaksi/transaksi_note_card.dart';
import 'package:my_budget/presentation/widget/transaksi/transaksi_type_switch.dart';

class TambahTransaksiPage extends StatefulWidget {
  const TambahTransaksiPage({super.key});

  @override
  State<TambahTransaksiPage> createState() => _TambahTransaksiPageState();
}

class _TambahTransaksiPageState extends State<TambahTransaksiPage> {
  TransactionType selectedType = TransactionType.pemasukan;
  bool isOtomatis = false;

  final TextEditingController noteController = TextEditingController();

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isPemasukan = selectedType == TransactionType.pemasukan;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Color(0xFF65BDFE),
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.biru1,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.button2Color,
          elevation: 0,
          centerTitle: true,
          title: Text(
            isPemasukan ? 'Tambahkan Pemasukan' : 'Tambahkan Pengeluaran',
            style: GoogleFonts.poppins(
              color: AppColors.biru1,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        body: Stack(
          children: [
            ClipPath(
              clipper: HeaderClipper(),
              child: Container(
                height: 200,
                width: double.infinity,
                color: AppColors.button2Color,
              ),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TransactionTypeSwitch(
                      selectedType: selectedType,
                      onChanged: (type) {
                        selectedType = type;
                        setState(() {});
                      }),
                  SizedBox(
                    height: 12,
                  ),
                  TransaksiAmountCard(
                    amount: isPemasukan ? 'Rp. 10.000' : 'Rp. 5000',
                    isOtomatis: isOtomatis,
                    onOtomatisChanged: (value) {
                      isOtomatis = value;
                      setState(() {});
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TransaksiCategoryCard(
                    category: 'Skincare',
                    icon: Icons.soup_kitchen,
                    bgIcon: Colors.blue,
                    onTap: () {},
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  TransaksiInfoCard(
                    rekening: isPemasukan ? 'Bank BRI' : 'Bank Mandiri',
                    tanggal: '22 Agustus 2025',
                    onTapRekening: () {},
                    onTapTanggal: () {},
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  TransaksiNoteCard(
                    controller: noteController,
                    icon: Icons.calendar_month_rounded,
                    label: 'Catatan',
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  ButtonRekening(
                      title: 'Simpan Transaksi',
                      onTap: () {
                        // Handle save transaction logic
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
