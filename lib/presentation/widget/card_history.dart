import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_budget/data/model/history_transaksi.dart';

class CardHistory extends StatelessWidget {
  final TransaksiHistoryData data;
  const CardHistory({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // Buat handling warna beda dari pemasukan dan pengeluaran
    final Color pColor =
        data.isPemasukan ? Color(0xFF2EAF15) : Color(0xFFBA1A1A);
    final String pText = data.isPemasukan ? '+' : '-';
    return Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: const Color.fromARGB(255, 202, 201, 201), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                offset: Offset(0, 3),
              )
            ]),
        child: Row(children: [
          Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: pColor, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    )
                  ]),
              child: Icon(
                data.icon,
                color: Colors.white,
                size: 24, 
              )), 
          SizedBox(width: 10),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(data.label,
                  maxLines: 1,
                  style: GoogleFonts.poppins( 
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  )),
              SizedBox(height: 4),
              Text(data.kategori,
                  maxLines: 1,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: const Color.fromARGB(255, 71, 68, 68),
                    fontWeight: FontWeight.w500,
                    height: 1,
                  )),
            ]),
          ),
          SizedBox(width: 10),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(
              "$pText Rp. ${data.jumlah}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: pColor,
                fontWeight: FontWeight.w700,
                height: 1,
              ),
            ),
            SizedBox(height: 4),
            Text(
              data.tanggal,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: const Color.fromARGB(255, 71, 68, 68),
                fontWeight: FontWeight.w500,
                height: 1,
              ),
            )
          ])
        ]));
  }
}
