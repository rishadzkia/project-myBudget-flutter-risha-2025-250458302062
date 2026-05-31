import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_budget/core/colors.dart';

class CategoryPage extends StatelessWidget {
  CategoryPage({super.key});

  final List<CategoryData> categories = [
    // Row 1
    CategoryData(
      icon: Icons.category_outlined,
      label: 'Belanja',
      color: Color(0xFFFFC1E3), // pastel pink
    ),
    CategoryData(
      icon: Icons.fastfood_rounded,
      label: 'Makanan',
      color: Color(0xFFFFD6A5), // pastel orange
    ),
    CategoryData(
      icon: Icons.coffee_rounded,
      label: 'Coffee',
      color: Color(0xFFD7C2FF), // pastel purple
    ),
    CategoryData(
      icon: Icons.directions_car_outlined,
      label: 'Transportasi',
      color: Color(0xFFAEDFF7), // pastel blue
    ),
    CategoryData(
      icon: Icons.favorite_outline,
      label: 'Donasi',
      color: Color(0xFFFFB3B3), // pastel red
    ),

    CategoryData(
      icon: Icons.restaurant_outlined,
      label: 'Makan',
      color: Color(0xFFFFE0B2), // pastel peach
    ),
    CategoryData(
      icon: Icons.card_giftcard_outlined,
      label: 'Hadiah',
      color: Color(0xFFDEC6FF), // pastel lavender
    ),
    CategoryData(
      icon: Icons.local_cafe_outlined,
      label: 'Coffee',
      color: Color(0xFFC8E6C9), // pastel green
    ),
    CategoryData(
      icon: Icons.apple,
      label: 'Buah',
      color: Color(0xFFFFD1DC), // pastel rose
    ),
    CategoryData(
      icon: Icons.brush_outlined,
      label: 'Make Up',
      color: Color(0xFFF8BBD0), // pastel pink soft
    ),

    CategoryData(
      icon: Icons.cake_outlined,
      label: 'Birthday',
      color: Color(0xFFFFE4C7), // pastel cream
    ),
    CategoryData(
      icon: Icons.phone_android_outlined,
      label: 'Handphone',
      color: Color(0xFFB3E5FC), // pastel sky blue
    ),
    CategoryData(
      icon: Icons.home_outlined,
      label: 'Rumah',
      color: Color(0xFFDCE775), // pastel lime
    ),
    CategoryData(
      icon: Icons.shopping_cart_outlined,
      label: 'Belanja',
      color: Color(0xFFFFCCBC), // pastel coral
    ),
    CategoryData(
      icon: Icons.local_shipping_outlined,
      label: 'Kurir',
      color: Color(0xFFB2DFDB), // pastel teal
    ),

    CategoryData(
      icon: Icons.spa_outlined,
      label: 'Salon',
      color: Color(0xFFE1BEE7), // pastel violet
    ),
    CategoryData(
      icon: Icons.directions_car_outlined,
      label: 'Transportasi',
      color: Color(0xFFBBDEFB), // pastel blue 2
    ),
    CategoryData(
      icon: Icons.account_balance_outlined,
      label: 'Bank',
      color: Color(0xFFD7CCC8), // pastel brown
    ),
    CategoryData(
      icon: Icons.fastfood_outlined,
      label: 'Jajan',
      color: Color(0xFFFFF59D), // pastel yellow
    ),
    CategoryData(
      icon: Icons.pets_outlined,
      label: 'Doggy',
      color: Color(0xFFFFCDD2), // pastel soft red
    ),

    CategoryData(
      icon: Icons.checkroom_outlined,
      label: 'Baju',
      color: Color(0xFFCFD8DC), // pastel grey-blue
    ),
    CategoryData(
      icon: Icons.restaurant_menu_outlined,
      label: 'Makanan',
      color: Color(0xFFFFE082), // pastel golden
    ),
    CategoryData(
      icon: Icons.work_outline,
      label: 'Pekerjaan',
      color: Color(0xFFB0BEC5), // pastel slate
    ),
    CategoryData(
      icon: Icons.sports_esports_outlined,
      label: 'Game',
      color: Color(0xFFCE93D8), // pastel purple soft
    ),
    CategoryData(
      icon: Icons.pets_outlined,
      label: 'Cat',
      color: Color(0xFFF48FB1), // pastel pink cat
    ),

    CategoryData(
      icon: Icons.fastfood_outlined,
      label: 'Jajan',
      color: Color(0xFFFFF176), // pastel yellow 2
    ),
    CategoryData(
      icon: Icons.face_outlined,
      label: 'Skincare',
      color: Color(0xFFFFAB91), // pastel peach skin
    ),
    CategoryData(
      icon: Icons.shopping_bag_outlined,
      label: 'Belanja',
      color: Color(0xFF80DEEA), // pastel cyan
    ),
    CategoryData(
      icon: Icons.devices_outlined,
      label: 'Digi',
      color: Color(0xFF90CAF9), // pastel tech blue
    ),
    CategoryData(
      icon: Icons.forest_outlined,
      label: 'Camp',
      color: Color(0xFFA5D6A7), // pastel forest green
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kategori',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: AppColors.biru2),
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
          padding: EdgeInsets.all(24),
          itemCount: categories.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 22,
              crossAxisSpacing: 10,
              childAspectRatio: 0.7),
          itemBuilder: (context, index) {
            return CategoryGridItem(
              data: categories[index],
              onTap: () {},
            );
          }),
    );
  }
}

class CategoryData {
  final IconData icon;
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
  const CategoryGridItem({super.key, required this.data, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
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
                  child: Icon(
                    data.icon,
                    color: Colors.white,
                    size: 28,
                  )),
              SizedBox(height: 6),
              Text(data.label,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: GoogleFonts.poppins(
                      fontSize: 13,
                      height: 1,
                      color: Colors.black,
                      fontWeight: FontWeight.w500))
            ])));
  }
}
