import 'package:flutter/material.dart';
import 'package:my_budget/presentation/page/utama/home_page.dart';
import 'package:my_budget/presentation/page/utama/kategori_page.dart';
import 'package:my_budget/presentation/page/utama/laporan_page.dart';
import 'package:my_budget/presentation/page/utama/transaksi_page.dart';
import 'package:my_budget/presentation/widget/nav/custom_button_navbar.dart';
import 'package:my_budget/presentation/widget/nav/custom_floating.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  bool _isCategoryPage = false;

  final List<Widget> _pages = [
    HomePage(),
    TransaksiPage(),
    LaporanPage(),
    Text('Level'),
  ];

  // Fungsi onItemTapped itu buat handling perpindahan halaman, jadi selectedIndex yang sekarang
  // bakal diganti dengan index yang baru

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _isCategoryPage = false;
    });
  }

  void _goToCategoryPage() {
    setState(() {
      _isCategoryPage = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isCategoryPage ? CategoryPage() : _pages[_selectedIndex],
      floatingActionButton: Transform.translate(
        offset: Offset(0, 35),
        child: GestureDetector(
          onTap: _goToCategoryPage,
          child: CustomFloatingButton(), 
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomButtonNavbar(
          selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
    );
  }
}
