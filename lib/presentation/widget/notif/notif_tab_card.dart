import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_budget/core/colors.dart';

class NotifTabCard extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  const NotifTabCard({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(children: [
        Expanded(
            child: NotifButton(
              title: 'Akan datang',
              icon: Icons.calendar_month_outlined, 
              isActive: selectedIndex == 0,
              onTap: () {
                onChanged(0);
              },
            ),
          ),

          const SizedBox(width: 8),

          Expanded(
            child: NotifButton(
              title: 'Terlambat',
              icon: Icons.close_rounded,
              isActive: selectedIndex == 1,
              onTap: () {
                onChanged(1);
              },
            ),
          ),

          const SizedBox(width: 8),

          Expanded(
            child: NotifButton(
              title: 'Selesai',
              icon: Icons.check_box_outlined, 
              isActive: selectedIndex == 2,
              onTap: () {
                onChanged(2);
              },
            ),
          ),

      ],),
    );
  }
}

class NotifButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;
  const NotifButton({
    super.key,
    required this.title,
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 36,
        padding: EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: isActive ? AppColors.button2Color : Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 16,
              offset: Offset(2, 4),
            )
          ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.black,
              size: 13,
              weight: 700,
            ),

            const SizedBox(width: 5),

            Flexible(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}