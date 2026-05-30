import 'package:flutter/material.dart';

enum TransactionType {
  pemasukan,
  pengeluaran,
}

class TransactionTypeSwitch extends StatelessWidget {
  final TransactionType selectedType;
  final ValueChanged<TransactionType> onChanged;

  const TransactionTypeSwitch({
    super.key,
    required this.selectedType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPemasukan = selectedType == TransactionType.pemasukan;

    return Container(
      width: double.infinity,
      height: 44,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0xFF129CF3).withOpacity(0.72),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        children: [
          Expanded(
            child: TransactionTypeButton(
              label: 'Pemasukan',
              icon: Icons.south_east_rounded,
              isActive: isPemasukan,
              activeBackgroundColor: const Color(0xFF007A3D),
              activeTextColor: const Color(0xFFA6EAC8),
              inactiveTextColor: const Color(0xFF007A3D),
              onTap: () {
                onChanged(TransactionType.pemasukan);
              },
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TransactionTypeButton(
              label: 'Pengeluaran',
              icon: Icons.north_west_rounded,
              isActive: !isPemasukan,
              activeBackgroundColor: const Color(0xFFF20D0D),
              activeTextColor: Colors.white,
              inactiveTextColor: const Color(0xFFF20D0D),
              onTap: () {
                onChanged(TransactionType.pengeluaran);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TransactionTypeButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isActive;
  final Color activeBackgroundColor;
  final Color activeTextColor;
  final Color inactiveTextColor;
  final VoidCallback onTap;

  const TransactionTypeButton({
    super.key,
    required this.label,
    required this.icon,
    required this.isActive,
    required this.activeBackgroundColor,
    required this.activeTextColor,
    required this.inactiveTextColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = isActive
        ? activeBackgroundColor
        : const Color(0xFFF3F3F3).withOpacity(0.88);

    final Color contentColor = isActive ? activeTextColor : inactiveTextColor;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        height: double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 15,
              color: contentColor,
            ),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                color: contentColor,
                fontSize: 13.5,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
