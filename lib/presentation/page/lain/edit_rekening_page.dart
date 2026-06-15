import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_budget/core/colors.dart';
import 'package:my_budget/data/request/create_account_request.dart';
import 'package:my_budget/data/response/account_response_model.dart';
import 'package:my_budget/presentation/bloc/account/account_bloc.dart';
import 'package:my_budget/presentation/widget/rekening/button_rekening.dart';
import 'package:my_budget/presentation/widget/rekening/simbol_card.dart';
import 'package:my_budget/presentation/widget/transaksi/transaksi_note_card.dart';

class EditRekeningPage extends StatefulWidget {
  final Account account;
  const EditRekeningPage({super.key, required this.account});
  @override
  State<EditRekeningPage> createState() => _EditRekeningPageState();
}

class _EditRekeningPageState extends State<EditRekeningPage> {
  late final ValueNotifier<int> selectedSymbolNotifier;
  bool _isSaving = false;
  final TextEditingController namaRekeningController = TextEditingController();

  final TextEditingController nominalController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    namaRekeningController.text =
        widget.account.accountName ?? 'Tidak ada rekening';
    final rawSaldo = double.tryParse(widget.account.saldo)?.toInt() ?? 0;
    nominalController.text = rawSaldo.toString();

    selectedSymbolNotifier = ValueNotifier<int>(widget.account.symbol);
  }

  @override
  void dispose() {
    namaRekeningController.dispose();

    nominalController.dispose();
    selectedSymbolNotifier.dispose();
    super.dispose();
  }

  // Fungsi untuk simpan data
  void _onSimpanData() {
    final namaRekening = namaRekeningController.text.trim();
    final saldoText = nominalController.text.trim();

    if (namaRekening.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Nama Rekening tidak boleh kosong',
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (saldoText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Saldo tidak boleh kosong',
            style: GoogleFonts.poppins(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final saldo = int.tryParse(
          saldoText.replaceAll('.', '').replaceAll('', ''),
        ) ??
        0;

    final symbol = selectedSymbolNotifier.value;

    setState(() {
      _isSaving = false;
    });

    context.read<AccountBloc>().add(AccountEvent.updateAccount(
        id: widget.account.id,
        model: CreateAccountRequestModel(
            accountName: namaRekening, saldo: saldo, symbol: symbol)));
  }

  IconData _getSymbolIcon(int index) {
    switch (index) {
      case 0:
        return Icons.money_rounded;
      case 1:
        return Icons.credit_card_rounded;
      case 2:
        return Icons.payment_rounded;
      case 3:
        return Icons.account_balance_wallet_rounded;
      case 4:
        return Icons.money_rounded;
      default:
        return Icons.money_rounded;
    }
  }

  Color _getSymbolColor(int index) {
    switch (index) {
      case 0:
        return AppColors.biru1;
      case 1:
        return AppColors.biru4;
      case 2:
        return Color(0xFF6C1104);
      case 3:
        return Color(0xFF006D37);
      case 4:
        return AppColors.button2Color;
      default:
        return AppColors.biru1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountBloc, AccountState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          success: (accounts) {
            _isSaving = false;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                'Rekening berhasil ditambahkan',
                style: GoogleFonts.poppins(),
              ),
              backgroundColor: Colors.green,
            ));
            Navigator.pop(context);
          },
          error: (message) {
            _isSaving = false;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                message,
                style: GoogleFonts.poppins(),
              ),
              backgroundColor: Colors.red,
            ));
            Navigator.pop(context);
          },
        );
        // TODO: implement listener
      },
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: AppColors.biru1,
          appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(
                'Edit Data Rekening',
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
                ),
              ),
              SafeArea(
                  child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.manual,
                padding: EdgeInsets.fromLTRB(20, 50, 20, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Untuk card tambah nominal
                    Container(
                        height: 140,
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(horizontal: 26, vertical: 20),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  AppColors.biru1,
                                  AppColors.biru2,
                                  Color(0xFF094985),
                                  Color(0xFF1273CE),
                                ]),
                            border: Border.all(
                                color: Color(0xFF65BDFE), width: 1.5),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              )
                            ]),
                        child: Column(children: [
                          Text('Input Nominal',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700)),
                          SizedBox(height: 10),
                          TextField(
                              controller: nominalController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  hintStyle: GoogleFonts.poppins(
                                      color: Colors.grey[200]),
                                  border: InputBorder.none,
                                  prefixText: 'Rp. ',
                                  prefixStyle: GoogleFonts.poppins(
                                      color: Colors.grey[200],
                                      fontSize: 2,
                                      fontWeight: FontWeight.w600)),
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600))
                        ])),
                    // end card tambah nominal

                    SizedBox(height: 28),
                    Text(
                      'Simbol Rekening',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 16),
                    // Simbol
                    ValueListenableBuilder(
                        valueListenable: selectedSymbolNotifier,
                        builder: (context, selectedSymbol, _) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(5, (index) {
                              return SimbolCard(
                                  icon: _getSymbolIcon(index),
                                  bgIcon: _getSymbolColor(index),
                                  isSelected: selectedSymbol == index,
                                  onTap: () {
                                    selectedSymbolNotifier.value = index;
                                  });
                            }),
                          );
                        }),

                    SizedBox(height: 16),
                    TransaksiNoteCard(
                        controller: namaRekeningController,
                        label: 'Nama Rekening'),

                    SizedBox(height: 50),
                    BlocBuilder<AccountBloc, AccountState>(
                      builder: (context, state) {
                        final isLoading = state.maybeWhen(
                          loading: () => true,
                          orElse: () => false,
                        );
                        return ButtonRekening(
                            title: 'Simpan Rekening', onTap: _onSimpanData);
                      },
                    )
                  ],
                ),
              ))
            ],
          )),
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
