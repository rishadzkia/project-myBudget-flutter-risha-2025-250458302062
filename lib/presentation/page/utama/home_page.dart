import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_budget/core/colors.dart';
import 'package:my_budget/data/local/auth_local_datasource.dart';
import 'package:my_budget/data/response/account_response_model.dart';
import 'package:my_budget/data/response/transaksi_response_model.dart';
import 'package:my_budget/presentation/bloc/account/account_bloc.dart';
import 'package:my_budget/presentation/bloc/danaterlindungi/danaterlindungi_bloc.dart';
import 'package:my_budget/presentation/bloc/transaksi/transaksi_bloc.dart';
import 'package:my_budget/presentation/page/lain/dana_terlindungi.dart';
import 'package:my_budget/presentation/page/lain/profile_page.dart';
import 'package:my_budget/presentation/page/lain/rekening_page.dart';
import 'package:my_budget/presentation/page/utama/kategori_page.dart';
import 'package:my_budget/presentation/page/utama/notifikasi_page.dart';
import 'package:my_budget/presentation/widget/category_card_widget.dart';
import 'package:my_budget/presentation/widget/dana_terlindungi_card_widget.dart';
import 'package:my_budget/presentation/widget/rekening_item_widget.dart';
import 'package:my_budget/presentation/widget/total_saldo_main_widget.dart';
import 'package:my_budget/presentation/widget/transaksi/transaksi_history_card.dart'
    as history;

Color hexToColor(String? hex) {
  if (hex == null || hex.isEmpty) return const Color(0xFFFF4FC3);

  final buffer = StringBuffer();

  if (hex.length == 7) {
    buffer.write('ff');
  }

  buffer.write(hex.replaceFirst('#', ''));

  return Color(int.parse(buffer.toString(), radix: 16));
}

class HomePage extends StatefulWidget {
  final VoidCallback? onLihatSemua;

  const HomePage({
    super.key,
    this.onLihatSemua,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    context.read<AccountBloc>().add(AccountEvent.getAccounts());
    context.read<TransaksiBloc>().add(TransaksiEvent.getTransactions());
    context.read<DanaterlindungiBloc>().add(
          DanaterlindungiEvent.getDanaTerlindungi(),
        ); 
  }

  bool _isToday(String? dateStr) {
    if (dateStr == null) return false;

    final date = DateTime.tryParse(dateStr)?.toLocal();
    if (date == null) return false;

    final now = DateTime.now();

    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  String _formatWaktu(String? dateStr) {
    if (dateStr == null) return '';

    final date = DateTime.tryParse(dateStr)?.toLocal();
    if (date == null) return '';

    return DateFormat('HH:mm', 'id').format(date);
  }

  String _formatRupiah(dynamic value) {
    final number = value is num
        ? value.toInt()
        : double.tryParse(value.toString())?.toInt() ?? 0;

    final result = number.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]}.',
        );

    return 'Rp $result';
  }

  int getTotalSaldo(List<Account> accounts) {
    return accounts.fold<int>(
      0,
      (previousValue, account) {
        final saldo = double.tryParse(account.saldo)?.toInt() ?? 0;
        return previousValue + saldo;
      },
    );
  }

  String formatTotalSaldo(String value) {
    final number = double.tryParse(value)?.toInt() ?? 0;

    final result = number.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]}.',
        );

    return 'Rp $result';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _HomeHeader(),
              const SizedBox(height: 16),
              FutureBuilder(
                future: AuthLocalDatasource().getAuthData(),
                builder: (context, data) {
                  final name = data.data?.user?.name ?? 'User MyBudget';

                  return Text(
                    'Halo $name 😋',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  );
                },
              ),
              const SizedBox(height: 4),
              Text(
                'Yuk, Kelola keuanganmu hari ini!',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(height: 8),
              BlocBuilder<AccountBloc, AccountState>(
                builder: (context, state) {
                  final accounts = state.maybeWhen(
                    success: (accounts) => accounts,
                    orElse: () => <Account>[],
                  );

                  final totalSaldo = getTotalSaldo(accounts);

                  return TotalSaldoMainWidget(
                    saldo: formatTotalSaldo(totalSaldo.toString()),
                  );
                },
              ),
              const SizedBox(height: 10),
              BlocBuilder<DanaterlindungiBloc, DanaterlindungiState>(
                builder: (context, state) {
                  final total = state.maybeWhen(
                    success: (data, total) => total,
                    orElse: () => 0.0,
                  );

                  final totalFormatted =
                      total.toInt().toString().replaceAllMapped(
                            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                            (match) => '${match[1]}.',
                          );

                  return DanaTerlindungiCardWidget(
                    jumlah: 'Rp. $totalFormatted',
                    text: 'Dana terlindungi',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DanaTerlindungiPage(),
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 24),
              CardCategory(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryPage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              RekeningItemWidget(
                label: 'Rekening',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RekeningPage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<TransaksiBloc, TransaksiState>(
                builder: (context, state) {
                  final allTransactions = state.maybeWhen(
                    success: (transactions) => transactions,
                    orElse: () => <TransactionModel>[],
                  );

                  final todayTransactions = allTransactions
                      .where(
                        (transaction) => _isToday(transaction.transactionTime),
                      )
                      .take(10)
                      .toList();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Riwayat Transaksi',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          TextButton(
                            onPressed: widget.onLihatSemua,
                            child: Text(
                              'Lihat Semua',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.biru3,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      if (todayTransactions.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 10,
                            top: 4,
                          ),
                          child: Text(
                            'Hari ini',
                            style: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      if (todayTransactions.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Center(
                            child: Text(
                              'Belum ada transaksi hari ini',
                              style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        )
                      else
                        ListView.builder(
                          itemCount: todayTransactions.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            final trans = todayTransactions[index];

                            return history.TransaksiHistoryCard(
                              data: history.TransaksiHistoryData(
                                icon: Icons.swap_horiz_rounded,
                                iconAssetPath: trans.category?.icon != null
                                    ? 'assets/icons/kategori/${trans.category!.icon}'
                                    : null,
                                iconBgColor: trans.category?.color != null
                                    ? hexToColor(trans.category!.color)
                                    : trans.type == 'pemasukan'
                                        ? const Color(0xFF008047)
                                        : const Color(0xFFD90429),
                                nama: trans.category?.category ??
                                    (trans.type == 'pemasukan'
                                        ? 'Pemasukan'
                                        : 'Pengeluaran'),
                                kategori: trans.account?.accountName ?? '-',
                                jumlah: _formatRupiah(trans.amount),
                                waktu: _formatWaktu(trans.transactionTime),
                                isPemasukan: trans.type == 'pemasukan',
                              ),
                            );
                          },
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'MyBudget',
          style: GoogleFonts.righteous(
            fontWeight: FontWeight.w400,
            fontSize: 24,
            color: AppColors.biru2,
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotifikasiPage(),
                  ),
                );
              },
              icon: Image.asset(
                'assets/icons/lonceng.png',
                width: 30,
                height: 30,
              ),
            ),
            const SizedBox(width: 8),
            _CircleIconButton(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ),
                );
              },
              borderColor: AppColors.biru4,
              borderWidth: 1.5,
              icon: Icons.person_2,
            ),
          ],
        ),
      ],
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color borderColor;
  final double borderWidth;

  const _CircleIconButton({
    required this.icon,
    required this.onTap,
    this.borderColor = AppColors.biru4,
    this.borderWidth = 1,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: borderColor,
            width: borderWidth,
          ),
          color: Colors.white,
        ),
        child: Center(
          child: Icon(
            icon,
            size: 20,
            color: const Color(0xFF455A64),
          ),
        ),
      ),
    );
  }
}
