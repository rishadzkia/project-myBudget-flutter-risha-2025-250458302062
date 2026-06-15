import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_budget/core/colors.dart';

class KategoriDialog extends StatelessWidget {
  final VoidCallback? onTransaksi;
  final VoidCallback? onManageKategori;
  final VoidCallback? onDetailKategori;
  const KategoriDialog(
      {super.key,
      this.onTransaksi,
      this.onManageKategori,
      this.onDetailKategori});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 28),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(24, 28, 24, 24),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 18,
                  offset: Offset(0, 8))
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.folder_copy_outlined,
              size: 50,
              color: AppColors.biru4,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Kelola Kategori',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              'Anda dapat mengelola\n kategori atau melanjutkan\n transaksi',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  height: 1,
                  fontWeight: FontWeight.w400,
                  color: AppColors.biru4),
            ),
            SizedBox(
              height: 22,
            ),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                  onPressed: onTransaksi,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.biru4,
                      elevation: 8,
                      shadowColor: Color(0xFF65BDFE).withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: Text(
                    'Lanjut ke Transaksi',
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  )),
            ),
            SizedBox(
              height: 12,
            ),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.biru3,
                      elevation: 8,
                      shadowColor: Color(0xFF65BDFE).withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: Text(
                    'Lanjut ke Transaksi',
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  )),
            ),
            SizedBox(
              height: 12,
            ),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.biru2,
                      elevation: 8,
                      shadowColor: Color(0xFF65BDFE).withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: Text(
                    'Detail Budget Kategori',
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  )),
            ),
            SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
