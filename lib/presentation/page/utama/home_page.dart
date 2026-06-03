import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_budget/core/colors.dart';
import 'package:my_budget/data/model/history_transaksi.dart';
import 'package:my_budget/presentation/page/lain/dana_terlindungi.dart';
import 'package:my_budget/presentation/page/lain/rekening_page.dart';
import 'package:my_budget/presentation/page/utama/kategori_page.dart';
import 'package:my_budget/presentation/widget/card_history.dart';
import 'package:my_budget/presentation/widget/category_card_widget.dart';
import 'package:my_budget/presentation/widget/dana_terlindungi_card_widget.dart';
import 'package:my_budget/presentation/widget/rekening_item_widget.dart';
import 'package:my_budget/presentation/widget/total_saldo_main_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<TransaksiHistoryData> _transaksi = [
    TransaksiHistoryData(
      icon: Icons.shopping_bag_rounded,
      label: 'Belanja Sayur',
      kategori: 'Belanja',
      jumlah: '50.000',
      tanggal: 'Minggu, 10 September 2023',
      isPemasukan: false,
    ),
    TransaksiHistoryData(
      icon: Icons.money_rounded,
      label: 'Gaji',
      kategori: 'Pemasukan',
      jumlah: '10.000.000',
      tanggal: 'Minggu, 10 September 2023',
      isPemasukan: true,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 16, 20, 120),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _HomeHeader(),
          SizedBox(
            height: 16,
          ),
          Text(
            'Halo Vyora 👋🏻',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            'Yuk, kelola keuanganmu hari ini!',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Colors.blueGrey),
          ),
          SizedBox(
            height: 8,
          ),
          TotalSaldoMainWidget(saldo: 'Rp.50.000.000'),
          SizedBox(
            height: 10,
          ),
          DanaTerlindungiCardWidget(
            jumlah: 'Rp.500.000',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DanaTerlindungiPage(),
                  ));
            },
          ),
          SizedBox(
            height: 24,
          ),
          CardCategory(onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CategoryPage()));
          }),
          SizedBox(
            height: 20,
          ),
          RekeningItemWidget(
              label: 'Rekening',
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RekeningPage()));
              }),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Riwayat Transaksi',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 16,
                )),
            TextButton(
                onPressed: () {},
                child: Text(
                  'Lihat Semua',
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: AppColors.biru3,
                      fontWeight: FontWeight.w500),
                )),
            SizedBox(height: 8),
          ]),
          ListView.builder(
            itemCount: _transaksi.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return CardHistory(data: _transaksi[index]);
            },
          )
        ]),
      )),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'MyBudget',
          style: GoogleFonts.righteous(
              fontWeight: FontWeight.w400,
              fontSize: 24,
              color: AppColors.biru2),
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: Image.asset(
                  'assets/icons/lonceng.png',
                  width: 30,
                  height: 30,
                )),
            SizedBox(
              width: 8,
            ),
            _CircleIconButton(
              onTap: () {},
              borderColor: AppColors.biru4,
              borderWidth: 1.5,
              icon: Icons.person_2,
            )
          ],
        )
      ],
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData? icon;
  final Widget? child;
  final VoidCallback onTap;
  final Color borderColor;
  final double borderWidth;

  const _CircleIconButton(
      {this.icon,
      required this.onTap,
      this.borderColor = AppColors.biru4,
      this.borderWidth = 1,
      this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: borderColor, width: borderWidth),
            color: Colors.white),
        child: Center(
          child: Icon(
            icon,
            size: 20,
            color: Color(0xFF455A64),
          ),
        ),
      ),
    );
  }
}
