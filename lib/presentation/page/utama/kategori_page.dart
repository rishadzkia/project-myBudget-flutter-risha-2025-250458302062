import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_budget/core/colors.dart';
import 'package:my_budget/data/model/category_icon_data.dart';
import 'package:my_budget/data/request/category_request_model.dart';
import 'package:my_budget/data/response/category_response_model.dart';
import 'package:my_budget/presentation/bloc/category/category_bloc.dart';
import 'package:my_budget/presentation/page/lain/tambah_transaksi.dart';
import 'package:my_budget/presentation/widget/dialog/create_category_dialog.dart';
import 'package:my_budget/presentation/widget/dialog/kategori_dialog.dart';

Color hexToColor(String? hex) {
  if (hex == null || hex.isEmpty) return const Color(0xFFFF4FC3);

  final buffer = StringBuffer();

  if (hex.length == 7) {
    buffer.write('ff');
  }

  buffer.write(hex.replaceFirst('#', ''));

  return Color(int.parse(buffer.toString(), radix: 16));
}

class CategoryPage extends StatefulWidget {
  CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(CategoryEvent.getCategories());
  }

  void _showTambahKategoriDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        useSafeArea: true,
        builder: (dialogContext) {
          return BlocProvider.value(
            value: context.read<CategoryBloc>(),
            child: TambahKategoriDialog(onSimpan: (nama, iconFileName, color) {
              context.read<CategoryBloc>().add(CategoryEvent.createCategory(
                  CreateCategoryRequestModel(
                      category: nama,
                      icon: iconFileName,
                      color: colorToHex(color))));
            }),
          );
        });
  }

  void _showHapusDialog(Categori cat) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              backgroundColor: const Color(0xFF053A67),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              title: Text(
                'Hapus Kategori',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              content: Text(
                'Hapus kategori "${cat.category}"?',
                style: GoogleFonts.poppins(color: Colors.white70, fontSize: 13),
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Batal',
                      style: GoogleFonts.poppins(
                        color: Colors.white60,
                      ),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);

                      context
                          .read<CategoryBloc>()
                          .add(CategoryEvent.deleteCategory(cat.id));
                    },
                    child: Text(
                      'Hapus',
                      style: GoogleFonts.poppins(
                          color: Colors.red, fontWeight: FontWeight.w700),
                    ))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryBloc, CategoryState>(
      listener: (context, state) {
        state.maybeWhen(
            orElse: () {},
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  message,
                  style: GoogleFonts.poppins(),
                ),
                backgroundColor: Colors.red,
              ));
            });
        // TODO: implement listener
      },
      builder: (context, state) {
        final categories = state.maybeWhen(
          orElse: () => <Categori>[],
          success: (categories) => categories,
        );
        final isLoading = state.maybeWhen(
          orElse: () => false,
          loading: () => true,
        );
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'Kategori',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: AppColors.biru2),
            ),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: _showTambahKategoriDialog,
                  child: Icon(
                    Icons.add,
                    color: AppColors.biru1,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
          body: isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : categories.isEmpty
                  ? Center(
                      child: Text(
                        'Belum ada kategori',
                        style: GoogleFonts.poppins(fontSize: 16),
                      ),
                    )
                  : GridView.builder(
                      padding: EdgeInsets.all(24),
                      itemCount: categories.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          mainAxisSpacing: 22,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.7),
                      itemBuilder: (context, index) {
                        final cat = categories[index];
                        return CategoryGridItem(
                          data: CategoryData(
                              icon: 'assets/icons/kategori/${cat.icon}',
                              label: cat.category,
                              color: hexToColor(cat.color)),
                          onLongPress: () => _showHapusDialog(cat),
                          onTap: () {
                            showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (context) {
                                  return KategoriDialog(
                                    onTransaksi: () {
                                      Navigator.pop(context);

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TambahTransaksiPage()));
                                    },
                                    onManageKategori: () {},
                                    onDetailKategori: () {},
                                  );
                                });
                          },
                        );
                      }),
        );
      },
    );
  }
}

class CategoryData {
  final String icon;
  final String label;
  final Color? color;

  CategoryData({
    required this.icon,
    required this.label,
    required this.color,
  });
}

class CategoryGridItem extends StatelessWidget {
  final CategoryData data;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  const CategoryGridItem(
      {super.key, required this.data, this.onTap, this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        onLongPress: onLongPress,
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
            width: 62,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: data.color,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.10),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        )
                      ]),
                  child: Image.asset(
                    data.icon,
                    color: Colors.white,
                  )),
              SizedBox(height: 6),
              Text(data.label,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: GoogleFonts.poppins(
                      fontSize: 11,
                      height: 1,
                      color: Colors.black,
                      fontWeight: FontWeight.w500))
            ])));
  }
}
