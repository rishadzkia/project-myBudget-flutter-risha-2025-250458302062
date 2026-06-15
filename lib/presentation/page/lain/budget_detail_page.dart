import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_budget/data/model/rekening_model.dart';

class BudgetTransactionModel {
  final String title;
  final String date;
  final double amount;

  const BudgetTransactionModel({
    required this.title,
    required this.date,
    required this.amount,
  });
}

class BudgetKategoriDetailPage extends StatelessWidget {
  const BudgetKategoriDetailPage({super.key});

  String get categoryName => 'Belanja';

  String get categoryIconPath => 'assets/icons/kategori/shopping.png';

  Color get categoryColor => const Color(0xFFFF4FC3);

  RekeningModel get rekening => RekeningModel(
        id: 1,
        nama: 'BRI utama',
        symbol: '🏦',
        iconBgColor: 0xFF5CB9F5,
        saldo: 1000000,
      );

  String get bulanLabel => 'Juni 2026';

  double get budgetBulanan => 1500000;

  double get budgetHarian => 50000;

  double get terpakaiBulanan => 450000;

  double get terpakaiHariIni => 25000;

  List<BudgetTransactionModel> get transactions => const [
        BudgetTransactionModel(
          title: 'Beli Bakso',
          date: '14 Juni 2026',
          amount: 20000,
        ),
        BudgetTransactionModel(
          title: 'Es Teh',
          date: '14 Juni 2026',
          amount: 5000,
        ),
        BudgetTransactionModel(
          title: 'Jajan Roti',
          date: '13 Juni 2026',
          amount: 15000,
        ),
      ];

  double get sisaBudgetBulanan {
    final result = budgetBulanan - terpakaiBulanan;
    return result < 0 ? 0 : result;
  }

  double get sisaBudgetHarian {
    final result = budgetHarian - terpakaiHariIni;
    return result < 0 ? 0 : result;
  }

  double get progressBulanan {
    if (budgetBulanan <= 0) return 0;

    final result = terpakaiBulanan / budgetBulanan;
    return result > 1 ? 1 : result;
  }

  double get progressHarian {
    if (budgetHarian <= 0) return 0;

    final result = terpakaiHariIni / budgetHarian;
    return result > 1 ? 1 : result;
  }

  String _formatRupiah(double value) {
    final number = value.toStringAsFixed(0);
    final chars = number.split('');
    final buffer = StringBuffer();

    for (int i = 0; i < chars.length; i++) {
      if (i > 0 && (chars.length - i) % 3 == 0) {
        buffer.write('.');
      }

      buffer.write(chars[i]);
    }

    return 'Rp ${buffer.toString()}';
  }

  Color _getProgressColor(double progress) {
    if (progress >= 0.9) return Colors.red;
    if (progress >= 0.7) return const Color(0xFFFFA000);

    return const Color(0xFF1565C0);
  }

  String _getStatusText(double progress) {
    if (progress >= 1) return 'Budget sudah habis';
    if (progress >= 0.9) return 'Hampir habis';
    if (progress >= 0.7) return 'Mulai mendekati batas';

    return 'Masih aman';
  }

  @override
  Widget build(BuildContext context) {
    final Color progressColor = _getProgressColor(progressBulanan);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF1565C0),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.chevron_left_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
        title: const Text(
          'Detail Budget',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 38,
              height: 38,
              margin: const EdgeInsets.only(right: 14),
              decoration: BoxDecoration(
                color: const Color(0xFF1565C0),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.edit_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _CategoryHeader(
                    categoryName: categoryName,
                    categoryIconPath: categoryIconPath,
                    categoryColor: categoryColor,
                    bulanLabel: bulanLabel,
                  ),
                  const SizedBox(height: 22),
                  _BudgetOverviewCard(
                    title: 'Budget Bulanan',
                    budget: _formatRupiah(budgetBulanan),
                    terpakai: _formatRupiah(terpakaiBulanan),
                    sisa: _formatRupiah(sisaBudgetBulanan),
                    progress: progressBulanan,
                    progressColor: progressColor,
                    statusText: _getStatusText(progressBulanan),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _SmallBudgetCard(
                          title: 'Budget Harian',
                          value: _formatRupiah(budgetHarian),
                          icon: Icons.today_rounded,
                          iconColor: const Color(0xFF1565C0),
                          bgColor: const Color(0xFFE3F2FD),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _SmallBudgetCard(
                          title: 'Sisa Hari Ini',
                          value: _formatRupiah(sisaBudgetHarian),
                          icon: Icons.savings_rounded,
                          iconColor: const Color(0xFF2E7D32),
                          bgColor: const Color(0xFFE8F5E9),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _DailyProgressCard(
                    terpakaiHariIni: _formatRupiah(terpakaiHariIni),
                    budgetHarian: _formatRupiah(budgetHarian),
                    progress: progressHarian,
                    progressColor: _getProgressColor(progressHarian),
                    statusText: _getStatusText(progressHarian),
                  ),
                  const SizedBox(height: 16),
                  _RekeningInfoCard(
                    rekening: rekening,
                    formatRupiah: _formatRupiah,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Riwayat Transaksi',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Text(
                        '${transactions.length} transaksi',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (transactions.isEmpty)
                    const _EmptyTransactionCard()
                  else
                    Column(
                      children: transactions.map((item) {
                        return _TransactionCard(
                          item: item,
                          nominal: _formatRupiah(item.amount),
                          categoryColor: categoryColor,
                          categoryIconPath: categoryIconPath,
                        );
                      }).toList(),
                    ),
                ],
              ),
            ),
          ),
          _BottomEditButton(
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _CategoryHeader extends StatelessWidget {
  final String categoryName;
  final String categoryIconPath;
  final Color categoryColor;
  final String bulanLabel;

  const _CategoryHeader({
    required this.categoryName,
    required this.categoryIconPath,
    required this.categoryColor,
    required this.bulanLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 68,
            height: 68,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: categoryColor,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: categoryColor.withOpacity(0.35),
                  blurRadius: 12,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Image.asset(
              categoryIconPath,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            categoryName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.calendar_month_rounded,
                  size: 15,
                  color: Color(0xFF1565C0),
                ),
                const SizedBox(width: 6),
                Text(
                  bulanLabel,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1565C0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BudgetOverviewCard extends StatelessWidget {
  final String title;
  final String budget;
  final String terpakai;
  final String sisa;
  final double progress;
  final Color progressColor;
  final String statusText;

  const _BudgetOverviewCard({
    required this.title,
    required this.budget,
    required this.terpakai,
    required this.sisa,
    required this.progress,
    required this.progressColor,
    required this.statusText,
  });

  @override
  Widget build(BuildContext context) {
    final percent = (progress * 100).toStringAsFixed(0);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF1565C0),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1565C0).withOpacity(0.28),
            blurRadius: 14,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.account_balance_wallet_rounded,
                color: Colors.white,
                size: 24,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  '$percent%',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            budget,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            statusText,
            style: TextStyle(
              fontSize: 13,
              color: Colors.white.withOpacity(0.85),
            ),
          ),
          const SizedBox(height: 18),
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 9,
              backgroundColor: Colors.white.withOpacity(0.25),
              valueColor: AlwaysStoppedAnimation<Color>(
                progressColor == const Color(0xFF1565C0)
                    ? Colors.white
                    : progressColor,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _BudgetTextInfo(
                  label: 'Terpakai',
                  value: terpakai,
                ),
              ),
              Container(
                width: 1,
                height: 36,
                color: Colors.white.withOpacity(0.25),
              ),
              Expanded(
                child: _BudgetTextInfo(
                  label: 'Sisa',
                  value: sisa,
                  alignEnd: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BudgetTextInfo extends StatelessWidget {
  final String label;
  final String value;
  final bool alignEnd;

  const _BudgetTextInfo({
    required this.label,
    required this.value,
    this.alignEnd = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withOpacity(0.75),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class _SmallBudgetCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;
  final Color bgColor;

  const _SmallBudgetCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 122,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFEAEAEA),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 20,
              color: iconColor,
            ),
          ),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class _DailyProgressCard extends StatelessWidget {
  final String terpakaiHariIni;
  final String budgetHarian;
  final double progress;
  final Color progressColor;
  final String statusText;

  const _DailyProgressCard({
    required this.terpakaiHariIni,
    required this.budgetHarian,
    required this.progress,
    required this.progressColor,
    required this.statusText,
  });

  @override
  Widget build(BuildContext context) {
    final percent = (progress * 100).toStringAsFixed(0);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFEAEAEA),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.insights_rounded,
                color: Color(0xFF1565C0),
                size: 22,
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Pemakaian Hari Ini',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
              Text(
                '$percent%',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: progressColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: const Color(0xFFE0E0E0),
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Text(
                  '$terpakaiHariIni dari $budgetHarian',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ),
              Text(
                statusText,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: progressColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RekeningInfoCard extends StatelessWidget {
  final RekeningModel rekening;
  final String Function(double value) formatRupiah;

  const _RekeningInfoCard({
    required this.rekening,
    required this.formatRupiah,
  });

  @override
  Widget build(BuildContext context) {
    final saldo = rekening.saldo ?? 0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: Color(rekening.iconBgColor ?? 0xFF1565C0),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Center(
              child: Text(
                rekening.symbol,
                style: const TextStyle(fontSize: 22),
              ),
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Rekening Budget',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  rekening.nama,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Saldo : ${formatRupiah(saldo)}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF1565C0),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            color: Color(0xFF1565C0),
            size: 26,
          ),
        ],
      ),
    );
  }
}

class _TransactionCard extends StatelessWidget {
  final BudgetTransactionModel item;
  final String nominal;
  final Color categoryColor;
  final String categoryIconPath;

  const _TransactionCard({
    required this.item,
    required this.nominal,
    required this.categoryColor,
    required this.categoryIconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFEAEAEA),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.045),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: categoryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(
              categoryIconPath,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  item.date,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black45,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '- $nominal',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyTransactionCard extends StatelessWidget {
  const _EmptyTransactionCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 24,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFEAEAEA),
        ),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 42,
            color: Colors.black26,
          ),
          SizedBox(height: 10),
          Text(
            'Belum ada transaksi',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Transaksi pada kategori ini akan muncul di sini.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black38,
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomEditButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _BottomEditButton({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: const Icon(
            Icons.edit_rounded,
            color: Colors.white,
            size: 20,
          ),
          label: const Text(
            'Edit Budget',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1565C0),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
            ),
          ),
        ),
      ),
    );
  }
}
