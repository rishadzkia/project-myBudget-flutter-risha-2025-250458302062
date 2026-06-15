import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_budget/core/account_symbol.dart';
import 'package:my_budget/data/response/account_response_model.dart';
import 'package:my_budget/presentation/bloc/account/account_bloc.dart';
import 'package:my_budget/presentation/page/lain/edit_rekening_page.dart';
import 'package:my_budget/presentation/widget/detail/detail_banner_card.dart';
import 'package:my_budget/presentation/widget/detail/filter_tanggal_card.dart';
import 'package:my_budget/presentation/widget/detail/rekening_summary_card.dart';
import 'package:my_budget/presentation/widget/transaksi/transaksi_history_card.dart';

class DetailRekeningPage extends StatefulWidget {
  final Account account;

  const DetailRekeningPage({
    super.key,
    required this.account,
  });

  @override
  State<DetailRekeningPage> createState() => _DetailRekeningPageState();
}

class _DetailRekeningPageState extends State<DetailRekeningPage> {
  String formatRupiah(String value) {
    final number = double.tryParse(value)?.toInt() ?? 0;
    final result = number.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]}.',
        );
    return 'Rp $result';
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AccountBloc>().add(const AccountEvent.getAccounts());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        // Ambil account terbaru dari BLoC state berdasarkan ID
        // Kalau belum ada di state (misal masih loading), fallback ke widget.account
        final currentAccount = state.maybeWhen(
          success: (accounts) {
            try {
              return accounts.firstWhere((a) => a.id == widget.account.id);
            } catch (_) {
              return widget.account;
            }
          },
          orElse: () => widget.account,
        );

        return Scaffold(
          backgroundColor: const Color(0xFF00233E),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0xFF209EF2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Detail Rekening',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 44),
                    ],
                  ),

                  const SizedBox(height: 38),

                  // Pakai currentAccount yang sudah fresh dari BLoC
                  DeatailBannerCard(
                    rekeningName: currentAccount.accountName,
                    amount: formatRupiah(currentAccount.saldo),
                    onEditTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditRekeningPage(
                            // Pass currentAccount bukan widget.account
                            // supaya edit page juga dapat data terbaru
                            account: currentAccount,
                          ),
                        ), 
                      );
                    },
                  ),

                  const SizedBox(height: 24),
                  const FilterTanggalCard(),
                  const SizedBox(height: 24),

                  Text(
                    'Ringkasan Bulan ini',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Row(
                    children: [
                      Expanded(
                        child: RekeningSummaryCard(
                          title: 'Pemasukan',
                          amount: 'Rp 1.000.000',
                          color: Color(0xFF17B86A),
                        ),
                      ),
                      SizedBox(width: 13),
                      Expanded(
                        child: RekeningSummaryCard(
                          title: 'Pengeluaran',
                          amount: 'Rp 0',
                          color: Color(0xFFFF1414),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  Text(
                    'Hari ini',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
