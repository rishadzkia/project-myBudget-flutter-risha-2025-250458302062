import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showTambahTagihanBottomSheet(BuildContext context) {
  final namaController = TextEditingController();
  final nominalController = TextEditingController();
  final tanggalController = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(24, 26, 24, 30),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(14),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tambah tagihan',
                  style: GoogleFonts.poppins(
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 22),
                _LabelInputTagihan(
                  icon: Icons.receipt_long_outlined,
                  label: 'Nama tagihan',
                ),
                const SizedBox(height: 7),
                _CustomInputTagihan(
                  controller: namaController,
                  hintText: 'Nama tagihan',
                ),
                const SizedBox(height: 14),
                _LabelInputTagihan(
                  icon: Icons.payments_outlined,
                  label: 'Nominal',
                ),
                const SizedBox(height: 7),
                _NominalInputTagihan(
                  controller: nominalController,
                ),
                const SizedBox(height: 14),
                _LabelInputTagihan(
                  icon: Icons.calendar_month_outlined,
                  label: 'Tanggal jatuh tempo',
                ),
                const SizedBox(height: 7),
                _TanggalInputTagihan(
                  controller: tanggalController,
                  onTap: () async {
                    final result = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                      initialDate: DateTime.now(),
                    );

                    if (result != null) {
                      tanggalController.text =
                          '${result.day}/${result.month}/${result.year}';
                    }
                  },
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFC9D0),
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.warning_amber_rounded,
                        color: Color(0xFFE53935),
                        size: 26,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Kami akan mengirim notifikasi sesuai\nwaktu pengingat yang kamu pilih',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            height: 1.35,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFFD7263D),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      // simpan data di sini
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0D6FB8),
                      elevation: 3,
                      shadowColor: Colors.black.withOpacity(0.35),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    child: Text(
                      'Simpan perubahan',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class _LabelInputTagihan extends StatelessWidget {
  final IconData icon;
  final String label;

  const _LabelInputTagihan({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: Colors.black,
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class _CustomInputTagihan extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const _CustomInputTagihan({
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 69,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.16),
            blurRadius: 7,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        style: GoogleFonts.poppins(
          fontSize: 14,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            fontSize: 14,
            color: const Color(0xFF777777),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 23,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class _NominalInputTagihan extends StatelessWidget {
  final TextEditingController controller;

  const _NominalInputTagihan({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 69,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.16),
            blurRadius: 7,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 30),
          Text(
            'Rp',
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 1,
            height: 45,
            color: Colors.black.withOpacity(0.25),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TanggalInputTagihan extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onTap;

  const _TanggalInputTagihan({
    required this.controller,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 69,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.16),
            blurRadius: 7,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        readOnly: true,
        onTap: onTap,
        style: GoogleFonts.poppins(
          fontSize: 14,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText: 'Pilih tanggal jatuh tempo',
          hintStyle: GoogleFonts.poppins(
            fontSize: 14,
            color: const Color(0xFF999999),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 23,
          ),
          border: InputBorder.none,
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 18),
            child: Icon(
              Icons.calendar_month_outlined,
              color: Colors.black,
              size: 25,
            ),
          ),
        ),
      ),
    );
  }
}
