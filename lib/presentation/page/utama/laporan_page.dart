import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_budget/core/colors.dart';
import 'package:my_budget/data/model/history_transaksi.dart';
import 'package:my_budget/presentation/widget/monitoring/monitoring_type_switch.dart';

class LaporanPage extends StatefulWidget {
  LaporanPage({super.key});

  @override
  State<LaporanPage> createState() => _LaporanPageState();
}

class _LaporanPageState extends State<LaporanPage> {
  // Page kebuka, menu langsung terbuka yang mingguan
  MonitoringType selectedType = MonitoringType.mingguan;
  final List<TransaksiHistoryData> _transaksi = [
    TransaksiHistoryData(
      icon: Icons.money_rounded,
      label: 'Benerin motor',
      kategori: 'Pemasukan',
      jumlah: '35.000',
      tanggal: 'Minggu, 10 September 2023',
      isPemasukan: true,
      // BgColor:
    ),
    TransaksiHistoryData(
      icon: Icons.money_rounded,
      label: 'Tambal ban',
      kategori: 'Setting',
      jumlah: '10.000',
      tanggal: 'Minggu, 10 September 2023',
      isPemasukan: true,
      // BgColor:
    ),
    TransaksiHistoryData(
      icon: Icons.money_rounded,
      label: 'Beli laptop',
      kategori: 'Pemasukan',
      jumlah: '10.000.000',
      tanggal: 'Minggu, 10 September 2023',
      isPemasukan: true,
      // BgColor:
    ),
    TransaksiHistoryData(
      icon: Icons.money_rounded,
      label: 'Gaji',
      kategori: 'Pemasukan',
      jumlah: '10.000.000',
      tanggal: 'Minggu, 10 September 2023',
      isPemasukan: true,
      // BgColor:
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Ringkasan & Monitoring',
          style: GoogleFonts.poppins(
            color: AppColors.biru1,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 22, 20, 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MonitoringTypeSwitch(
                selectedType: selectedType,
                onChanged: (value) {
                  selectedType = value;
                  setState(() {
                    
                  });
                })
          ],
        ),
      ),
    );
  }
}
