import 'package:flutter/material.dart';
import 'package:my_budget/presentation/widget/nav/maskot_button.dart';
import 'package:my_budget/presentation/widget/nav/nav_tem.dart';

class CustomButtonNavbar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  const CustomButtonNavbar(
      {super.key, required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        color: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.1),
        child: SizedBox(
            height: 72,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BottomNavItem(
                    icon: 'assets/icons/nav/home.png',
                    label: 'Beranda',
                    isActive: selectedIndex == 0,
                    onTap: () => onItemTapped(0),
                  ),
                  BottomNavItem(
                    icon: 'assets/icons/nav/transaksi.png',
                    label: 'Transaksi',
                    isActive: selectedIndex == 1,
                    onTap: () => onItemTapped(1),
                  ),
                  // Jaarak untuk ke floating action button
                  SizedBox(width: 64),

                  BottomNavItem(
                    icon: 'assets/icons/nav/laporan.png',
                    label: 'Laporan',
                    isActive: selectedIndex == 2,
                    onTap: () => onItemTapped(2),
                  ),
                  MaskotButtonNav(
                    isActive: selectedIndex == 3,
                    onTap: () => onItemTapped(3),
                  )
                ])));
  }
}
