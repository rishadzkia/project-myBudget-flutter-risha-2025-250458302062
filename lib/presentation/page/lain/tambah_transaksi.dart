import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_budget/core/colors.dart';
import 'package:my_budget/data/request/transkasi_request_model.dart';
import 'package:my_budget/data/response/account_response_model.dart';
import 'package:my_budget/data/response/category_response_model.dart';
import 'package:my_budget/presentation/bloc/account/account_bloc.dart';
import 'package:my_budget/presentation/bloc/transaksi/transaksi_bloc.dart';
import 'package:my_budget/presentation/page/main_page.dart';
import 'package:my_budget/presentation/page/utama/kategori_page.dart';
import 'package:my_budget/presentation/widget/bottomSheet/rekening_bs.dart';
import 'package:my_budget/presentation/widget/rekening/button_rekening.dart';
import 'package:my_budget/presentation/widget/transaksi/transaksi_amount_card.dart';
import 'package:my_budget/presentation/widget/transaksi/transaksi_category_card.dart';
import 'package:my_budget/presentation/widget/transaksi/transaksi_info_card.dart';
import 'package:my_budget/presentation/widget/transaksi/transaksi_note_card.dart';
import 'package:my_budget/presentation/widget/transaksi/transaksi_type_switch.dart';

Color hexToColor(String? hex) {
  if (hex == null || hex.isEmpty) return const Color(0xFFFF4FC3);

  final buffer = StringBuffer();

  if (hex.length == 7) {
    buffer.write('ff');
  }

  buffer.write(hex.replaceFirst('#', ''));

  return Color(int.parse(buffer.toString(), radix: 16));
}

DateTime _nowWib() {
  final wib = DateTime.now().toUtc().add(const Duration(hours: 7));

  return DateTime(
    wib.year,
    wib.month,
    wib.day,
    wib.hour,
    wib.minute,
    wib.second,
  );
}

class TambahTransaksiPage extends StatefulWidget {
  final Categori? initialCategory;
  const TambahTransaksiPage({super.key, this.initialCategory});

  @override
  State<TambahTransaksiPage> createState() => _TambahTransaksiPageState();
}

class _TambahTransaksiPageState extends State<TambahTransaksiPage> {
  TransactionType selectedType = TransactionType.pemasukan;
  bool isOtomatis = false;

  bool _isSaving = false;

  final TextEditingController amountController = TextEditingController();

  Categori? selectedCategory;
  Account? selectedAccount;

  late DateTime selectedDate;

  bool get isPemasukan => selectedType == TransactionType.pemasukan;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedCategory = widget.initialCategory;
    selectedDate = _nowWib();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AccountBloc>().add(AccountEvent.getAccounts());
    });
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: color,
      ),
    );
  }

  String _formatDateLabel(DateTime date) {
    final now = _nowWib();

    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final selected = DateTime(date.year, date.month, date.day);

    if (selected == today) return 'Hari ini';
    if (selected == yesterday) return 'Kemarin';

    return DateFormat('dd MMM yyyy', 'id').format(date);
  }

  String _formatDateForApi(DateTime date) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF5CB9F5),
              onPrimary: Colors.white,
              surface: Color(0xFF053A67),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked == null) return;

    final now = _nowWib();

    setState(() {
      selectedDate = DateTime(
        picked.year,
        picked.month,
        picked.day,
        now.hour,
        now.minute,
        now.second,
      );
    });
  }

  Future<void> _pickRekening(List<Account> accounts) async {
    if (accounts.isEmpty) {
      _showSnackBar('Belum ada rekening', Colors.red);
      return;
    }

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return RekeningBottomSheet(
          accounts: accounts,
          selectedAccount: selectedAccount,
          onSelected: (account) {
            setState(() {
              selectedAccount = account;
            });

            Navigator.pop(context);
          },
        );
      },
    );
  }

  Future<void> _pickKategori() async {
    final result = await Navigator.push<Categori>(
      context,
      MaterialPageRoute(
        builder: (_) => CategoryPage(),
      ),
    );

    if (result == null) return;

    setState(() {
      selectedCategory = result;
    });
  }

  double _getAmount() {
    final rawAmount = amountController.text
        .trim()
        .replaceAll('.', '')
        .replaceAll(',', '')
        .replaceAll(' ', '');

    return double.tryParse(rawAmount) ?? 0;
  }

  void _goToTransaksiPage() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => const MainPage(initialIndex: 1),
      ),
      (route) => false,
    );
  }

  void _onSimpan() {
    final amount = _getAmount();

    if (amount <= 0) {
      _showSnackBar('Nominal tidak boleh kosong', Colors.red);
      return;
    }

    if (selectedAccount == null) {
      _showSnackBar('Pilih rekening dulu', Colors.red);
      return;
    }

    final transactionTime = _formatDateForApi(selectedDate);

    debugPrint('=== TANGGAL DIKIRIM: $transactionTime');
    debugPrint('=== JAM WIB SEKARANG: ${_formatDateForApi(_nowWib())}');

    setState(() {
      _isSaving = true;
    });

    context.read<TransaksiBloc>().add(
          TransaksiEvent.createTransactions(
            CreateTransactionRequestModel(
              accountId: selectedAccount!.id,
              categoryId: selectedCategory?.id,
              type: isPemasukan ? 'pemasukan' : 'pengeluaran',
              amount: amount,
              transactionTime: transactionTime,
            ),
          ),
        );
  }

  void _setDefaultAccount(List<Account> accounts) {
    if (selectedAccount != null || accounts.isEmpty) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || selectedAccount != null) return; // ✅ double check
      setState(() {
        selectedAccount = accounts.first;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransaksiBloc, TransaksiState>(
      listenWhen: (previous, current) => _isSaving,
      listener: (context, state) {
        state.maybeWhen(
            orElse: () {},
            success: (_) {
              _isSaving = false;
              context.read<AccountBloc>().add(AccountEvent.getAccounts());
              context
                  .read<TransaksiBloc>()
                  .add(TransaksiEvent.getTransactions());

              _showSnackBar('Transaksi berhasil disimpan', Colors.lightGreen);
              _goToTransaksiPage();
            },
            error: (message) {
              _isSaving = false;
              _showSnackBar(message, Colors.red);
            });
        // TODO: implement listener
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            statusBarColor: Color(0xFF65BDFE),
            statusBarIconBrightness: Brightness.dark),
        child: Scaffold(
          backgroundColor: AppColors.biru1,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.button2Color,
            elevation: 0,
            centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.all(10),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Color(0xFF1F8FE5),
                      borderRadius: BorderRadius.circular(12)),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
            ),
            title: Text(
              isPemasukan ? 'Tambahkan Pemasukan' : 'Tambahkan Pengeluaran',
              style: GoogleFonts.poppins(
                  color: AppColors.biru1,
                  fontSize: 20,
                  fontWeight: FontWeight.w800),
            ),
          ),
          body: BlocBuilder<AccountBloc, AccountState>(
            builder: (context, accountState) {
              final accounts = accountState.maybeWhen(
                success: (accounts) => accounts,
                orElse: () => <Account>[],
              );
              return Stack(
                children: [
                  ClipPath(
                    clipper: HeaderClipper(),
                    child: Container(
                        height: 200,
                        width: double.infinity,
                        color: AppColors.button2Color),
                  ),
                  SingleChildScrollView(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        TransactionTypeSwitch(
                          selectedType: selectedType,
                          onChanged: (type) {
                            setState(() {
                              selectedType = type;
                            });
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TransaksiAmountCard(
                            controller: amountController,
                            isOtomatis: isOtomatis,
                            onOtomatisChanged: (value) {
                              isOtomatis = value;
                              setState(() {});
                            }),
                        SizedBox(
                          height: 16,
                        ),
                        TransaksiCategoryCard(
                          category:
                              selectedCategory?.category ?? 'Pilih Kategori',
                          iconPath: selectedCategory == null
                              ? null
                              : 'assets/icons/kategori/${selectedCategory!.icon}',
                          icon: Icons.category_outlined,
                          bgIcon: selectedCategory == null
                              ? Colors.grey
                              : hexToColor(selectedCategory!.color),
                          onTap: _pickKategori,
                        ),
                        SizedBox(height: 22),
                        TransaksiInfoCard(
                          rekening:
                              selectedAccount?.accountName ?? 'Pilih rekening',
                          tanggal: _formatDateLabel(selectedDate),
                          onTapRekening: () => _pickRekening(accounts),
                          onTapTanggal: _pickDate,
                        ),
                        SizedBox(height: 60),
                        BlocBuilder<TransaksiBloc, TransaksiState>(
                          builder: (context, state) {
                            final isLoading = state.maybeWhen(
                                loading: () => true, orElse: () => false);
                            return ButtonRekening(
                                title: isLoading
                                    ? 'Menyimpan data...'
                                    : 'Simpan transaksi',
                                onTap: (isLoading ? () {} : _onSimpan));
                          },
                        )
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
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
