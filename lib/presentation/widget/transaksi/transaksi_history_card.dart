import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TransaksiHistoryData {
  final IconData icon;
  final String? iconAssetPath;
  final Color iconBgColor;
  final String nama;
  final String kategori;
  final String jumlah;
  final bool isPemasukan;
  final String waktu;

  const TransaksiHistoryData({
    required this.icon,
    this.iconAssetPath,
    required this.iconBgColor,
    required this.nama,
    required this.kategori,
    required this.jumlah,
    required this.isPemasukan,
    required this.waktu,
  });
}

class TransaksiHistoryCard extends StatelessWidget {
  final TransaksiHistoryData data;

  const TransaksiHistoryCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final String amountPrefix = data.isPemasukan ? '+' : '-';
    final Color amountColor =
        data.isPemasukan ? const Color(0xFF159F24) : const Color(0xFFD71920);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.black12,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: data.iconBgColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.14),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: data.iconAssetPath != null
                ? Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      data.iconAssetPath!,
                      color: Colors.white,
                    ),
                  )
                : Icon(
                    data.icon,
                    color: Colors.white,
                    size: 24,
                  ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.nama,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0E172A),
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  data.kategori,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF4A4A4A),
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$amountPrefix Rp ${data.jumlah}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: amountColor,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                data.waktu,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF4A4A4A),
                  height: 1.2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
