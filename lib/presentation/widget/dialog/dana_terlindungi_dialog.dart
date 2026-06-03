import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_budget/core/colors.dart';

class DanaTerlindungiDialog extends StatelessWidget {
  final TextEditingController nominalController;
  final VoidCallback onSimpan;
  const DanaTerlindungiDialog(
      {super.key, required this.nominalController, required this.onSimpan});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.biru2, AppColors.biru3]),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white.withAlpha(64), width: 1),
            boxShadow: [BoxShadow(color: Colors.black.withAlpha(64))]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Tambahkan Dana Terlindungi',
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              'Masukan Nominal Dana Terlindungi',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.8)),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: nominalController,
              keyboardType: TextInputType.number,
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
              decoration: InputDecoration(
                  hintText: 'Rp 70.000',
                  hintStyle: GoogleFonts.poppins(
                    color: Colors.white.withOpacity(0.4),
                  ),
                  prefixText: 'Rp. ',
                  prefixStyle: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                          color: Colors.white.withOpacity(0.2), width: 1)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.white, width: 1))),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Colors.white.withOpacity(0.25), width: 1)),
                    child: Center(
                      child: Text(
                        'Batal',
                        style: GoogleFonts.poppins(
                            fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                )),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                    child: GestureDetector(
                  onTap: onSimpan,
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: Text(
                        'Simpan',
                        style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.biru1),
                      ),
                    ),
                  ),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
