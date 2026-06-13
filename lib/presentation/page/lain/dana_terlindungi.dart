import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_budget/core/colors.dart';
import 'package:my_budget/data/request/dana_terlindungi_request_model.dart';
import 'package:my_budget/data/response/account_response_model.dart';
import 'package:my_budget/presentation/bloc/account/account_bloc.dart';
import 'package:my_budget/presentation/bloc/danaterlindungi/danaterlindungi_bloc.dart';
import 'package:my_budget/presentation/widget/dialog/dana_terlindungi_dialog.dart'; 

class DanaTerlindungiPage extends StatefulWidget { 
  const DanaTerlindungiPage({super.key});

  @override
  State<DanaTerlindungiPage> createState() => _DanaTerlindungiPageState();
}

class _DanaTerlindungiPageState extends State<DanaTerlindungiPage> { 
  final TextEditingController nominalController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AccountBloc>().add(AccountEvent.getAccounts());
    context
        .read<DanaterlindungiBloc>()
        .add(DanaterlindungiEvent.getDanaTerlindungi());
  }

  @override
  void dispose() {
    nominalController.dispose();
    super.dispose();
  }

  String formatRupiah(String value) {
    final number = double.tryParse(value)?.toInt() ?? 0;

    final result = number.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]}.',
        );

    return 'Rp $result';
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DanaterlindungiBloc, DanaterlindungiState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          success: (data, total) {
            context.read<AccountBloc>().add(AccountEvent.getAccounts());
          },
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                message,
                style: GoogleFonts.poppins(),
              ),
              backgroundColor: Colors.red,
            ));
          },
        );
        // TODO: implement listener
      },
      child: Scaffold(
        backgroundColor: AppColors.biru1,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.biru1,
                      AppColors.biru2,
                      AppColors.biru3,
                    ]),
              ),
            ), 
            SafeArea(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,  
                  children: [
                    DanaBackButton(
                      onTap: () {
                        // Ini cuman balik atau menghapus halaman sebelumnya aja
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox( 
                      height: 48,
                    ),
                    Center(
                      child: Column(
                        children: [
                          Row(mainAxisSize: MainAxisSize.min, children: [
                            Image.asset(
                              'assets/home_page/shield.png',
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text('Dana Terlindungi',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: Colors.white)),
                          ]),
                          SizedBox(
                            height: 12,
                          ),
                          Text('Aman, terkunci, dan hanya untuk tujuanmu',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.white,
                              )),
                          SizedBox(
                            height: 24,
                          ),
                          Image.asset(
                            'assets/home_page/harta_karun.png',
                            width: 280,
                            height: 280,
                            fit: BoxFit.contain,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 14),
                    Text('Total Dana Terkunci',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white,
                        )),
                    SizedBox(height: 4),
                    BlocBuilder<DanaterlindungiBloc, DanaterlindungiState>(
                      builder: (context, state) {
                        final total = state.maybeWhen(
                          orElse: () => 0,
                          success: (data, total) => total,
                        );
                        return Text(formatRupiah(total.toString()),
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                              color: Colors.white,
                            ));
                      },
                    ),
                    SizedBox(height: 6),
                    Text(
                        'Dana ini tidak dapat digunakan\nuntuk transaksi harian',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          height: 1.5,
                          color: Colors.white,
                        )),
                    Spacer(),
                    BlocBuilder<AccountBloc, AccountState>(
                      builder: (context, state) {
                        final accounts = state.maybeWhen(
                            orElse: () => <Account>[],
                            success: (accounts) => accounts);

                        return BlocBuilder<DanaterlindungiBloc,
                            DanaterlindungiState>(
                          builder: (context, danaState) {
                            final isLoading = danaState.maybeWhen(
                              orElse: () => false,
                              loading: () => true,
                            );
                            return GestureDetector(
                              onTap: isLoading
                                  ? null
                                  : () {
                                      if (accounts.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Belum ada rekening, tambah rekening dulu',
                                              style: GoogleFonts.poppins(),
                                            ),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                        return;
                                      }

                                      nominalController.clear();

                                      showDialog(
                                        context: context,
                                        builder: (_) => InputNominalDialog(
                                          controller: nominalController,
                                          accounts: accounts,
                                          onSimpan: (accountId) {
                                            if (nominalController.text.isEmpty)
                                              return;

                                            final nominal = int.tryParse(
                                                  nominalController.text,
                                                ) ??
                                                0;

                                            context
                                                .read<DanaterlindungiBloc>()
                                                .add(
                                                  DanaterlindungiEvent
                                                      .createDanaTerlindungi(
                                                    CreateDanaTerlindungiRequestModel(
                                                      accountId: accountId,
                                                      nominal: nominal,
                                                    ),
                                                  ),
                                                );

                                            Navigator.pop(context);
                                          },
                                        ),
                                      );
                                    },
                              behavior: HitTestBehavior.opaque,
                              child: Container(
                                width: double.infinity,
                                height: 58,
                                decoration: BoxDecoration(
                                  color: isLoading
                                      ? Colors.white.withOpacity(0.08)
                                      : Colors.white.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.2),
                                    width: 1,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.12),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: isLoading
                                      ? const SizedBox(
                                          width: 22,
                                          height: 22,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2.5,
                                          ),
                                        )
                                      : Text(
                                          '+ Dana Terlindungi',
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DanaBackButton extends StatelessWidget {
  final VoidCallback? onTap;

  const DanaBackButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.12),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }
}
