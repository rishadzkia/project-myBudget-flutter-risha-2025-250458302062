import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_budget/core/account_symbol.dart';
import 'package:my_budget/core/colors.dart';
import 'package:my_budget/data/response/account_response_model.dart';
import 'package:my_budget/presentation/bloc/account/account_bloc.dart';
import 'package:my_budget/presentation/page/lain/detail_rekening_page.dart';
import 'package:my_budget/presentation/page/lain/tambah_rekening_page.dart';
import 'package:my_budget/presentation/widget/rekening/button_rekening.dart';
import 'package:my_budget/presentation/widget/rekening/rekening_card.dart';
import 'package:my_budget/presentation/widget/rekening/total_saldo_card.dart';

class RekeningPage extends StatefulWidget {
  const RekeningPage({super.key});

  @override
  State<RekeningPage> createState() => _RekeningPageState();
}

class _RekeningPageState extends State<RekeningPage> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AccountBloc>().add(AccountEvent.getAccounts());
    });
  }

  String formatRupiah(String value) {
    final number = double.tryParse(value)?.toInt() ?? 0;

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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountBloc, AccountState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(message),
              backgroundColor: Colors.red,
            ));
          },
        );
        // TODO: implement listener
      },
      builder: (context, state) {
        final accounts = state.maybeWhen(
          orElse: () => <Account>[],
          success: (accounts) => accounts,
        );
        final totalSaldo = getTotalSaldo(accounts);
        return Scaffold(
            backgroundColor: AppColors.biru1,
            appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: Text(
                  'Rekening',
                  style: GoogleFonts.poppins(
                      color: AppColors.biru1,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                leading: GestureDetector(
                    onTap: () {
                      // nge back. Buat balik ke halaman sebelumnya atau nutup alert dialog
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                      decoration: BoxDecoration(
                        color: AppColors.biru1,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ))),
            body: Stack(
              children: [
                ClipPath(
                    clipper: HeaderClipper(),
                    child: Container(
                      height: 165,
                      width: double.infinity,
                      color: AppColors.button2Color,
                    )),

                // Biar page responsif, bisa di scroll kalau widget nya banyak
                SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(20, 58, 20, 40),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TotalSaldoCard(
                            title: 'TOTAL SALDO',
                            nominal: formatRupiah(totalSaldo.toString())),
                        SizedBox(height: 32),
                        Text(
                          'Rekening Virtual',
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 16),
                        RekeningListCard(
                            icon: Icons.attach_money_rounded,
                            bgColor: AppColors.biru4,
                            title: 'M-Banking BSI',
                            nominal: 'Rp 5.000.000'),
                        SizedBox(height: 16),
                        state.maybeWhen(orElse: () {
                          return SizedBox();
                        }, loading: () {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }, error: (message) {
                          return Text(
                            message,
                            style: GoogleFonts.poppins(
                                color: Colors.red,
                                fontSize: 13,
                                fontWeight: FontWeight.w600),
                          );
                        }, success: (accounts) {
                          if (accounts.isEmpty) {
                            return Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 24),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Text(
                                'Belum ada rekening virtual',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            );
                          }

                          return ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final account = accounts[index];

                                return RekeningListCard(
                                  icon: AccountSymbol.getIcon(account.symbol),
                                  bgColor:
                                      AccountSymbol.getColor(account.symbol),
                                  title: account.accountName,
                                  nominal: formatRupiah(account.saldo),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DetailRekeningPage(
                                                    account: account)));
                                  },
                                  onDeleteTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            backgroundColor: Color(0xFF0F6FB3),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16)),
                                            title: Text(
                                              'Hapus Rekening',
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            content: Text(
                                              'Yakin ingin menghaous rekening ini?',
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white60,
                                                  fontSize: 14),
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: Text(
                                                    'Batal',
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.white38),
                                                  )),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    context
                                                        .read<AccountBloc>()
                                                        .add(AccountEvent
                                                            .deleteAccount(
                                                                account.id));
                                                  },
                                                  child: Text(
                                                    'Hapus',
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ))
                                            ],
                                          );
                                        });
                                  },
                                );
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                    height: 16,
                                  ),
                              itemCount: accounts.length);
                        }),
                        SizedBox(height: 56),
                        ButtonRekening(
                            title: 'Tambah Rekening',
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) =>
                                          TambahRekeningPage()));
                            })
                      ]),
                )
              ],
            ));
      },
    );
  }
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0, size.height * 0.72);

    path.quadraticBezierTo(
      size.width * 0.50,
      size.height * 1.15,
      size.width,
      size.height * 0.72,
    );

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
