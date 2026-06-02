import 'package:flutter/material.dart';

class SimbolCard extends StatelessWidget {
  final IconData icon;
  final Color bgIcon;
  final bool isSelected;
  final VoidCallback onTap;
  const SimbolCard(
      {super.key,
      required this.icon,
      required this.bgIcon,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      // Fungsi behavior HitTestBehavior.opaque memastikan bahwa seluruh area kartu
      //dapat menerima sentuhan, bukan hanya bagian yang terlihat.
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color: isSelected ? bgIcon : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border:
                Border.all(color: isSelected ? Colors.white : bgIcon, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.10),
                blurRadius: 16,
                offset: Offset(2, 4),
              )
            ]),
        child: Icon(icon, color: Colors.white, size: 24),
      ),
    );
  }
}
