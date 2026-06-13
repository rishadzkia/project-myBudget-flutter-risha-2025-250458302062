import 'package:flutter/material.dart';

class AccountSymbol {
  static const List<IconData> icons = [
    Icons.money_rounded,
    Icons.credit_card_rounded,
    Icons.payments_rounded,
    Icons.attach_money_rounded,
    Icons.account_balance_wallet_rounded,
  ];

  static const List<Color> colors = [
    Color(0xFF00233E),
    Color(0xFF6A9DB9),
    Color(0xFF8A1E12),
    Color(0xFF00783B),
    Color(0xFF209EF2),
  ];

  static IconData getIcon(int index) {
    if (index < 0 || index >= icons.length) return icons[0];
    return icons[index];
  }

  static Color getColor(int index) {
    if (index < 0 || index >= colors.length) return colors[0];
    return colors[index];
  }
}
