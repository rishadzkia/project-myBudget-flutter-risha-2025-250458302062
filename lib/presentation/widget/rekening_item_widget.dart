import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RekeningItemWidget extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  const RekeningItemWidget({super.key, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border:
                  Border.all(color: Colors.black.withOpacity(0.25), width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                )
              ],
            ),
            child: Row(children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: Color(0xFF6C1104),
                    borderRadius: BorderRadius.circular(12)),
                child: Icon(
                  Icons.account_balance_wallet_outlined,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Text(
                  label,
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward_ios_rounded,
                  color: Colors.black, size: 18)
            ])));
  }
}
