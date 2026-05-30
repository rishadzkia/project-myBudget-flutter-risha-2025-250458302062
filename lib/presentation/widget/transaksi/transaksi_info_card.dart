import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TransaksiInfoCard extends StatelessWidget {
  final String rekening;
  final String tanggal;
  final VoidCallback? onTapRekening;
  final VoidCallback? onTapTanggal;
  const TransaksiInfoCard(
      {super.key,
      required this.rekening,
      required this.tanggal,
      this.onTapRekening,
      this.onTapTanggal});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: _SmallInfoCard(
          title: 'Rekening',
          value: rekening,
          icon: Icons.account_balance_wallet_outlined,
          onTap: onTapRekening,
        )),
        SizedBox(
          width: 12,
        ),
        Expanded(
            child: _SmallInfoCard(
          title: 'Tanggal',
          value: tanggal,
          icon: Icons.calendar_view_day_rounded,
          onTap: onTapTanggal,
        )),
      ],
    );
  }
}

class _SmallInfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final VoidCallback? onTap;

  const _SmallInfoCard(
      {required this.title,
      required this.value,
      required this.icon,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          height: 90,
          padding: EdgeInsets.fromLTRB(14, 12, 14, 12),
          decoration: BoxDecoration(
              color: Color(0xFF043869),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: Offset(0, 4))
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 2,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Icon(
                    icon,
                    size: 24,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Text(  
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
