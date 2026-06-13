import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LevelMonthData {
  final String month;
  final double lebarGambar;
  final double tinggiGambar;

  LevelMonthData({
    required this.month,
    required this.lebarGambar,
    required this.tinggiGambar,
  });
}

class LevelMonthCard extends StatelessWidget {
  final int selectedMonthIndex;
  const LevelMonthCard({super.key, required this.selectedMonthIndex});

  @override
  Widget build(BuildContext context) {
    final List<LevelMonthData> months = [
      LevelMonthData(month: 'Jan', lebarGambar: 28, tinggiGambar: 28),
      LevelMonthData(month: 'Feb', lebarGambar: 33, tinggiGambar: 33),
      LevelMonthData(month: 'Mar', lebarGambar: 39, tinggiGambar: 39),
      LevelMonthData(month: 'Apr', lebarGambar: 48, tinggiGambar: 48),
      LevelMonthData(month: 'Mei', lebarGambar: 56, tinggiGambar: 56),
      LevelMonthData(month: 'Jun', lebarGambar: 65, tinggiGambar: 65),
      LevelMonthData(month: 'Jul', lebarGambar: 74, tinggiGambar: 74),
    ];
    return Container(
      width: double.infinity,
      height: 154,
      decoration: BoxDecoration(
        color: const Color(0xFF73BDF2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -140,
            left: -70,
            child: Container(
              width: 245,
              height: 245,
              decoration: const BoxDecoration(
                color: Color(0xFF2F7FC6),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    blurRadius: 13,
                    offset: Offset(1, 8),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 30, 8, 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(months.length, (index) {
                final bool isSelected = selectedMonthIndex == index;

                return Expanded(
                  child: MaskotMonthItem(
                    data: months[index],
                    isSelected: isSelected,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class MaskotMonthItem extends StatelessWidget {
  final LevelMonthData data;
  final bool isSelected;

  const MaskotMonthItem({
    super.key,
    required this.data,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Image.asset(
          'assets/maskot/maskot_kecil.png',
          width: data.lebarGambar,
          height: data.tinggiGambar,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 6),
        Text(
          data.month,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color:
                isSelected ? const Color(0xFF00233E) : const Color(0xFF4A5A66),
          ),
        ),
      ],
    );
  }
}
