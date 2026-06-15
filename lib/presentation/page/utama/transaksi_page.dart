import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_budget/core/colors.dart';
import 'package:my_budget/data/response/transaksi_response_model.dart';
import 'package:my_budget/presentation/bloc/transaksi/transaksi_bloc.dart';
import 'package:my_budget/presentation/page/lain/tambah_transaksi.dart';
import 'package:my_budget/presentation/widget/transaksi/transaksi_action_button.dart';
import 'package:my_budget/presentation/widget/transaksi/transaksi_history_card.dart';

Color hexToColor(String? hex) {
  if (hex == null || hex.isEmpty) return const Color(0xFFFF4FC3);

  final buffer = StringBuffer();

  if (hex.length == 7) {
    buffer.write('ff');
  }

  buffer.write(hex.replaceFirst('#', ''));

  return Color(int.parse(buffer.toString(), radix: 16));
}

class TransaksiPage extends StatefulWidget {
  TransaksiPage({super.key});

  @override
  State<TransaksiPage> createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  @override
  void initState() {
    super.initState();
    context.read<TransaksiBloc>().add(TransaksiEvent.getTransactions());
  }

  Map<String, List<TransactionModel>> _groupByDate(
    List<TransactionModel> transactions,
  ) {
    final Map<String, List<TransactionModel>> grouped = {};

    for (final t in transactions) {
      final label = _dateLabel(t.transactionTime);
      grouped.putIfAbsent(label, () => []).add(t);
    }

    return grouped;
  }

  String _dateLabel(String? dateStr) {
    if (dateStr == null) return 'Tidak diketahui';

    final date = DateTime.tryParse(dateStr)?.toLocal();
    if (date == null) return 'Tidak diketahui';

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final selected = DateTime(date.year, date.month, date.day);

    if (selected == today) return 'Hari ini';
    if (selected == yesterday) return 'Kemarin';
    return DateFormat('dd MMM yyyy', 'id').format(date);
  }

  String _formatRupiah(double value) {
    final number = value.toInt();
    final result = number.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]}.',
        );
    return result;
  }

  String _formatWaktu(String? dateStr) {
    if (dateStr == null) return '';
    final date = DateTime.tryParse(dateStr)?.toLocal();
    if (date == null) return '';
    return DateFormat('HH:mm', 'id').format(date);
  }

  void _navigateToTambahTransaksi() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const TambahTransaksiPage(),
      ),
    ).then((_) {
      context.read<TransaksiBloc>().add(
            const TransaksiEvent.getTransactions(),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: 260,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColors.button2Color, Colors.white])),
          ),
          SafeArea(
            child: BlocBuilder<TransaksiBloc, TransaksiState>(
              builder: (context, state) {
                final transactions = state.maybeWhen(
                    orElse: () => <TransactionModel>[],
                    success: (transactions) => transactions);

                final isLoading =
                    state.maybeWhen(orElse: () => false, loading: () => true);

                final sorted = [...transactions]..sort((a, b) {
                    final dateA = DateTime.tryParse(
                          a.transactionTime ?? '',
                        ) ??
                        DateTime(0);
                    final dateB = DateTime.tryParse(
                          b.transactionTime ?? '',
                        ) ??
                        DateTime(0);

                    return dateB.compareTo(dateA);
                  });

                final grouped = _groupByDate(sorted);
                final groupKeys = grouped.keys.toList();
                return SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(20, 46, 20, 120),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Transaksi',
                        style: GoogleFonts.poppins(
                            color: AppColors.biru1,
                            fontSize: 20,
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Semua transaksi dalam satu tempat, lebih mudah dipantau setiap hari.',
                        style: GoogleFonts.poppins(
                            color: AppColors.biru1,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            height: 1.5),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TransaksiActionButton(
                                title: 'Tambah',
                                subTitle: 'Pemasukan',
                                icon: Icons.south_east_rounded,
                                bgColorCard: Color(0xFF006D37),
                                bgIconColor: Color(0xFF068F4B),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) =>
                                              TambahTransaksiPage()));
                                }),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: TransaksiActionButton(
                                title: 'Tambah',
                                subTitle: 'Pengeluaran',
                                icon: Icons.north_east_rounded,
                                bgColorCard: Color(0xFFC60E1F),
                                bgIconColor: Color(0xFFFB2C36),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) =>
                                              TambahTransaksiPage()));
                                }),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                        'Riwayat Transaksi',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      if (isLoading)
                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 32),
                            child: CircularProgressIndicator(
                              color: AppColors.biru1,
                            ),
                          ),
                        )
                      else if (transactions.isEmpty)
                        Center(
                          child: Text(
                            'Belum ada transaksi',
                            style: GoogleFonts.poppins(
                                color: Colors.grey, fontSize: 16),
                          ),
                        )
                      else
                        ListView.builder(
                            itemCount: groupKeys.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, groupIndex) {
                              final label = groupKeys[groupIndex];
                              final items = grouped[label]!;

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      label,
                                      style: GoogleFonts.poppins(
                                          color: Colors.grey,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  ListView.builder(
                                      itemCount: items.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        final trans = items[index];
                                        return TransaksiHistoryCard(
                                            data: TransaksiHistoryData(
                                                icon: Icons.swap_horiz_rounded,
                                                iconAssetPath: trans
                                                            .category?.icon !=
                                                        null
                                                    ? 'assets/icons/kategori/${trans.category!.icon}'
                                                    : null,
                                                iconBgColor: trans
                                                            .category?.color !=
                                                        null
                                                    ? hexToColor(trans
                                                        .category!.color)
                                                    : trans.type == 'Pemasukan'
                                                        ? Color(0xFF008047)
                                                        : Color(0xFFD90429),
                                                nama:
                                                    trans.category?.category ??
                                                        (trans.type ==
                                                                'Pemasukan'
                                                            ? 'Pemasukan'
                                                            : 'Pengeluaran'),
                                                kategori: trans
                                                        .account?.accountName ??
                                                    '_',
                                                jumlah:
                                                    _formatRupiah(trans.amount),
                                                waktu: _formatWaktu(
                                                    trans.transactionTime),
                                                isPemasukan:
                                                    trans.type == 'Pemasukan'));
                                      }),
                                ],
                              );
                            }),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
