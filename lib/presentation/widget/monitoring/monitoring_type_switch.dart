import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_budget/core/colors.dart';

enum MonitoringType { mingguan, bulanan }

class MonitoringTypeSwitch extends StatelessWidget {
  final MonitoringType selectedType;
  final ValueChanged<MonitoringType> onChanged;
  const MonitoringTypeSwitch(
      {super.key, required this.selectedType, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final bool isMingguan = selectedType == MonitoringType.mingguan;
    return Container(
      width: double.infinity,
      height: 55,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: AppColors.biru1, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Expanded(
            child: MonitoringTypeButton(
                title: 'Mingguan',
                isActive: isMingguan,
                onTap: () {
                  onChanged(MonitoringType.mingguan);
                }),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: MonitoringTypeButton(
                title: 'Bulanan',
                isActive: !isMingguan,
                onTap: () {
                  onChanged(MonitoringType.bulanan);
                }),
          ),
        ],
      ),
    );
  }
}

class MonitoringTypeButton extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const MonitoringTypeButton(
      {super.key,
      required this.title,
      required this.isActive,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        height: double.infinity,
        decoration: BoxDecoration(
          color: isActive ? AppColors.button2Color : Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.poppins(
                color: isActive ? Colors.white : Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
