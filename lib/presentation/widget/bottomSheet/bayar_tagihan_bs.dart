import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_budget/presentation/widget/notif/notif_input.dart';

class BayarTagihanBottomSheet extends StatefulWidget {
  const BayarTagihanBottomSheet({super.key});

  @override
  State<BayarTagihanBottomSheet> createState() =>
      _BayarTagihanBottomSheetState();
}

class _BayarTagihanBottomSheetState extends State<BayarTagihanBottomSheet> {
  final nominalController = TextEditingController();
  final tanggalController = TextEditingController();
  final metodePembayaranController = TextEditingController();

  void dispose() {
    nominalController.dispose();
    tanggalController.dispose();
    metodePembayaranController.dispose();
    super.dispose();
  }

  Future<void> pilihTanggal() async {
    final DateTime? pickedDate = await showDatePicker(
        context: context, firstDate: DateTime(2000), lastDate: DateTime(2100));

    if (pickedDate != null) {
      tanggalController.text =
          '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      padding: EdgeInsets.fromLTRB(22, 22, 22, keyboardHeight + 26),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Bayar Tagihan',
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
            SizedBox(
              height: 28,
            ),
            Row(
              children: [
                Icon(
                  Icons.credit_card_rounded,
                  color: Colors.black,
                  size: 22,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  "Metode Pembayaran",
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                )
              ],
            ),
            const SizedBox(height: 10),
            NotifInput(
              controller: metodePembayaranController,
              hintText: 'Metode pembayaran',
              suffixIcon: Icons.account_balance_wallet_rounded,
              readOnly: true,
              onTap: () {},
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                const Icon(
                  Icons.payments_outlined,
                  color: Colors.black,
                  size: 22,
                ),
                const SizedBox(width: 8),
                Text(
                  'Nominal',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              height: 68,
              decoration: BoxDecoration(
                color: const Color(0xFFF7F7F7),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: const Color(0xFFD9D9D9),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(width: 18),
                  Text(
                    'Rp',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 1,
                    height: 50,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: nominalController,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.black,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: '',
                        border: InputBorder.none,
                        isCollapsed: true,
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                ],
              ),
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                const Icon(
                  Icons.calendar_month_outlined,
                  color: Colors.black,
                  size: 22,
                ),
                const SizedBox(width: 8),
                Text(
                  'Tanggal Pembayaran',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            NotifInput(
              controller: tanggalController,
              hintText: 'Masukan tanggal pembayaran',
              suffixIcon: Icons.calendar_month_outlined,
              readOnly: true,
              onTap: pilihTanggal,
            ),
            const SizedBox(height: 78),
            SizedBox(
              width: double.infinity,
              height: 68,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1672B4),
                  elevation: 3,
                  shadowColor: Colors.black.withOpacity(0.25),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Sudah Bayar',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
