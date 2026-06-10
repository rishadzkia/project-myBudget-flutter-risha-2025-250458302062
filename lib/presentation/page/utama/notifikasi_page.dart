import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_budget/core/colors.dart';
import 'package:my_budget/presentation/widget/bottomSheet/bayar_tagihan_bs.dart';
import 'package:my_budget/presentation/widget/bottomSheet/tambah_tagihan_bs.dart';
import 'package:my_budget/presentation/widget/dialog/tagihan_dialog.dart';
import 'package:my_budget/presentation/widget/notif/notif_banner_card.dart';
import 'package:my_budget/presentation/widget/notif/notif_bill_card.dart';
import 'package:my_budget/presentation/widget/notif/notif_tab_card.dart';
import 'package:my_budget/presentation/widget/notif/notif_tambah_button.dart';

class NotifikasiPage extends StatefulWidget {
  const NotifikasiPage({super.key});

  @override
  State<NotifikasiPage> createState() => _NotifikasiPageState();
}

class _NotifikasiPageState extends State<NotifikasiPage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.biru1,
      appBar: AppBar(
        backgroundColor: AppColors.biru1,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Pengingat Tagihan',
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 40,
            height: 40,
            margin: EdgeInsets.only(left: 30, top: 16, bottom: 10),
            decoration: BoxDecoration(
              color: AppColors.button2Color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 18,
            ),
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 35, 20, 26),
          child: Column(
            children: [
              NotifBannerCard(),
              SizedBox(height: 17),
              NotifTabCard(
                selectedIndex: selectedIndex,
                onChanged: (index) {
                  selectedIndex = index;
                  setState(() {});
                },
              ),
              SizedBox(
                height: 16,
              ),
              NotifBillCard(
                title: 'Internet',
                date: '20 Mei 2026',
                amount: 'Rp 30.000',
                status: 'Minggu depan',
                statusColor: const Color(0xFF65BDFE),
                statusTextColor: const Color(0xFF00233E),
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return const BayarTagihanBottomSheet();
                      });
                },
              ),
              SizedBox(
                height: 16,
              ),
              NotifBillCard(
                title: 'Listrik',
                date: '20 Mei 2026',
                amount: 'Rp 30.000',
                status: 'Minggu depan',
                statusColor: const Color(0xFFFA7E7E),
                statusTextColor: const Color(0xFF00233E),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return TagihanNotifDialog(
                            title: 'Listrik',
                            subtitle: 'Tagihan listrikmu jatuh tempo pada ',
                            totalTagihan: 'Rp 30.000',
                            date: 'tanggal 14 mei 2026',
                            onDetailTap: () {
                              Navigator.pop(context);
                            },
                            icon: 'assets/icon/icon_calender.png');
                      });
                },
              ),
              SizedBox(
                height: 100,
              ),
              NotifTambahButton(onTap: () {
                showTambahTagihanBottomSheet(context);
              })
            ],
          ),
        ),
      ),
    );
  }
}
