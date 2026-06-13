import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_budget/core/colors.dart';
import 'package:my_budget/data/request/create_account_request.dart';
import 'package:my_budget/presentation/bloc/account/account_bloc.dart';
import 'package:my_budget/presentation/widget/rekening/button_rekening.dart';
import 'package:my_budget/presentation/widget/rekening/simbol_card.dart';
import 'package:my_budget/presentation/widget/transaksi/transaksi_note_card.dart';

class TambahRekeningPage extends StatefulWidget {
  const TambahRekeningPage({super.key});

  @override
  State<TambahRekeningPage> createState() => _TambahRekeningPageState();
}

class _TambahRekeningPageState extends State<TambahRekeningPage> {
  final TextEditingController namaRekeningController = TextEditingController();

  final TextEditingController nominalController = TextEditingController();

// Terpilih satu simbol
  int selectedSymbol = 0;

  @override
  void dispose() {
    namaRekeningController.dispose();

    nominalController.dispose();
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

    final saldo = int.tryParse(saldoText) ?? 0;
    context.read<AccountBloc>().add(AccountEvent.createAccount(
        CreateAccountRequestModel(
            accountName: namaRekening, saldo: saldo, symbol: selectedSymbol)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountBloc, AccountState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          success: (accounts) {
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
                'Tambah Rekening',
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
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700)),
                          SizedBox(height: 10),
                          TextField(
                              controller: nominalController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  hintText: 'Masukkan nominal...',
                                  hintStyle: GoogleFonts.poppins(
                                      color: Colors.grey[200]),
                                  border: InputBorder.none,
                                  prefixText: 'Rp ',
                                  prefixStyle: GoogleFonts.poppins(
                                      color: Colors.grey[200],
                                      fontSize: 24,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SimbolCard(
                          icon: Icons.money_rounded,
                          bgIcon: AppColors.biru1,
                          isSelected: selectedSymbol == 0,
                          onTap: () {
                            setState(() {
                              selectedSymbol = 0;
                            });
                          },
                        ),
                        SizedBox(width: 4),
                        SimbolCard(
                          icon: Icons.credit_card_rounded,
                          bgIcon: AppColors.biru4,
                          isSelected: selectedSymbol == 1,
                          onTap: () {
                            setState(() {
                              selectedSymbol = 1;
                            });
                          },
                        ),
                        SizedBox(width: 4),
                        SimbolCard(
                          icon: Icons.payment_rounded,
                          bgIcon: Color(0xFF6C1104),
                          isSelected: selectedSymbol == 2,
                          onTap: () {
                            setState(() {
                              selectedSymbol = 2;
                            });
                          },
                        ),
                        SizedBox(width: 4),
                        SimbolCard(
                          icon: Icons.attach_money_rounded,
                          bgIcon: Color(0xFF006D37),
                          isSelected: selectedSymbol == 3,
                          onTap: () {
                            setState(() {
                              selectedSymbol = 3;
                            });
                          },
                        ),
                        SizedBox(width: 4),
                        SimbolCard(
                          icon: Icons.account_balance_wallet_rounded,
                          bgIcon: AppColors.button2Color,
                          isSelected: selectedSymbol == 4,
                          onTap: () {
                            setState(() {
                              selectedSymbol = 4;
                            });
                          },
                        ),
                      ],
                    ),

                    SizedBox(height: 16),
                    TransaksiNoteCard(
                        controller: namaRekeningController,
                        label: 'Nama Rekening'),

                    SizedBox(height: 50),
                    BlocBuilder<AccountBloc, AccountState>(
                      builder: (context, state) {
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
