import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_budget/core/account_symbol.dart';
import 'package:my_budget/core/colors.dart';
import 'package:my_budget/data/response/account_response_model.dart';
import 'package:my_budget/presentation/page/lain/rekening_page.dart';

class RekeningBottomSheet extends StatefulWidget {
  final List<Account> accounts;
  final Account? selectedAccount;
  final Function(Account) onSelected;
  const RekeningBottomSheet(
      {super.key,
      required this.accounts,
      this.selectedAccount,
      required this.onSelected});

  @override
  State<RekeningBottomSheet> createState() => _RekeningBottomSheetState();
}

class _RekeningBottomSheetState extends State<RekeningBottomSheet> {
  Account? selectedAccount;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedAccount = widget.selectedAccount;
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
    return Container(
      padding: EdgeInsets.fromLTRB(17, 33, 17, 24),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                    color: AppColors.button2Color,
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: Icon(
                            Icons.close_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                        )),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Rekening',
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          'Pilih rekening untuk digunakan',
                          style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Material(
                    color: AppColors.button2Color,
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                        onTap: () => Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return RekeningPage();
                            })),
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: Icon(
                            Icons.settings,
                            color: Colors.white,
                            size: 24,
                          ),
                        )),
                  ),
                ],
              ),

              SizedBox(
                height: 18,
              ),

              // List Rekening
              widget.accounts.isEmpty
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'Belum ada rekening',
                        style: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 220,
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        physics: BouncingScrollPhysics(),
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 8,
                          );
                        },
                        itemCount: widget.accounts.length,
                        itemBuilder: (context, index) {
                          final account = widget.accounts[index];
                          final isSelected = selectedAccount?.id == account.id;

                          return _RekeningItemCard(
                              title: account.accountName,
                              saldo: account.saldo,
                              icon: AccountSymbol.getIcon(account.symbol),
                              iconColor: Colors.white,
                              iconBg: AccountSymbol.getColor(account.symbol),
                              isSelected: isSelected,
                              onTap: () {
                                setState(() => selectedAccount = account);
                              });
                        },
                      ),
                    ),

              SizedBox(
                height: 20,
              ),

              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                decoration: BoxDecoration(
                    color: Color(0XFFD3ECFF),
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(
                        Icons.verified_user_rounded,
                        color: AppColors.biru2,
                        size: 22,
                      ),
                    ),
                    SizedBox(
                      width: 14,
                    ),
                    Expanded(
                      child: Text(
                        'Setiap transaksi akan dicatat pada\n rekening yang kamu pilih.',
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            height: 1.3,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF0977B8)),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                    onPressed: () {
                      if (selectedAccount == null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Pilih rekening terlebih dahulu')));
                        return;
                      }
                      widget.onSelected(selectedAccount!);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1379BD),
                        elevation: 3,
                        shadowColor: Colors.black.withOpacity(0.25),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6))),
                    child: Text(
                      'Simpan',
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    )),
              )
            ],
          )),
    );
  }
}

class _RekeningItemCard extends StatelessWidget {
  final String title;
  final String saldo;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final bool isSelected;
  final VoidCallback onTap;
  const _RekeningItemCard({
    required this.title,
    required this.saldo,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Mirip sama conatiner, cuma biasanya dipake buat bungkus sesuatu yang bakal ada efeknya kayak inkwell
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      elevation: 2.5,
      shadowColor: Colors.black.withOpacity(0.2),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 64,
          padding: EdgeInsets.symmetric(horizontal: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0XFFEAEAEA), width: 1),
          ),
          child: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.22),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      )
                    ]),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 22,
                ),
              ),
              SizedBox(
                width: 17,
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Saldo : $saldo',
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  )
                ],
              )),

// Radio
              Container(
                width: 13,
                height: 13,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: isSelected
                    ? Center(
                        child: Container(
                          width: 7,
                          height: 7,
                          decoration: BoxDecoration(
                              color: AppColors.button2Color,
                              shape: BoxShape.circle),
                        ),
                      )
                    : null,
              )
            ],
          ),
        ),
      ),
    );
  }
}
