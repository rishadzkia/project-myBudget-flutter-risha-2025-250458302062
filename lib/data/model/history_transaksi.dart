import 'package:flutter/material.dart';

class TransaksiHistoryData {
  final IconData icon;
  final Color? BgColor;
  final String label;
  final String kategori;
  final String jumlah;

  final String tanggal;
  final bool isPemasukan;

  TransaksiHistoryData(
      {required this.icon,
      this.BgColor,
      required this.label,
      required this.kategori,
      required this.jumlah,
      required this.tanggal,
      required this.isPemasukan});
}
