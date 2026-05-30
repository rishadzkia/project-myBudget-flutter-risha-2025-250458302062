import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_budget/core/colors.dart';
import 'package:my_budget/presentation/widget/transaksi/transaksi_amount_card.dart';
import 'package:my_budget/presentation/widget/transaksi/transaksi_info_card.dart';
import 'package:my_budget/presentation/widget/transaksi/transaksi_note_card.dart';
import 'package:my_budget/presentation/widget/transaksi/transaksi_type_switch.dart';

class TransaksiPage extends StatefulWidget {
  const TransaksiPage({super.key});

  @override
  State<TransaksiPage> createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  final TransactionType selectedType = TransactionType.pemasukan;
  bool isOtomatis = false;
  final TextEditingController noteController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isPemasukan = selectedType == TransactionType.pemasukan;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: Color(0xFF65BDFE),
          statusBarIconBrightness: Brightness.dark),
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
                fontWeight: FontWeight.w800),
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
                  SizedBox(
                    height: 10,
                  ),
                  TransactionTypeSwitch(
                    selectedType: selectedType,
                    onChanged: (type) {
                      selectedType = type;
                      setState(() {});
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TransaksiAmountCard(
                      amount: isPemasukan ? 'Rp 10.000' : 'Rp 5000',
                      isOtomatis: isOtomatis,
                      onOtomatisChanged: (value) {
                        isOtomatis = value;
                        setState(() {});
                      }),
                  SizedBox(
                    height: 22, 
                  ),
                  TransaksiInfoCard(
                    rekening: isPemasukan ? 'Bank BRI' : 'Bank Mandiri',
                    tanggal: '22 Agustus 2023',
                    onTapRekening: () {},
                    onTapTanggal: () {},
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  TransaksiNoteCard(controller: noteController)
                ],
              ),
            )
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
