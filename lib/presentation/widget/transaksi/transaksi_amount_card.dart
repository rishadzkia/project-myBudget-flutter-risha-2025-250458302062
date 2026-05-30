import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_budget/core/colors.dart';

class TransaksiAmountCard extends StatelessWidget {
  final String amount;
  // Ini untuk toggle
  final bool isOtomatis;
  // Ini untuk logic toggle nya
  final ValueChanged<bool> onOtomatisChanged;
  const TransaksiAmountCard({
    super.key,
    required this.amount,
    required this.isOtomatis,
    required this.onOtomatisChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Color(0xFF043869),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: Offset(0, 4),
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Jumlah',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Spacer(),
              Transform.scale(
                scale: 0.8,
                child: Switch(
                  value: isOtomatis,
                  activeColor: Colors.white,
                  activeTrackColor: AppColors.button2Color,
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Colors.grey,
                  onChanged: onOtomatisChanged,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                'Otomatis',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            amount,
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w800,
                height: 1), 
          )
        ],
      ),
    );
  }
}
