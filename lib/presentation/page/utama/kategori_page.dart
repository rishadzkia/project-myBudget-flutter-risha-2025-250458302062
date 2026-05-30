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
      color: Color(0xFFFF7EDF),
    ),
    CategoryData(
      icon: Icons.fastfood_rounded,
      label: 'Makanan',
      color: Color(0xFF1F8FE5),
    ),
    CategoryData(
      icon: Icons.coffee_rounded,
      label: 'Coffee',
      color: Colors.black,
    ),
    CategoryData(
      icon: Icons.directions_car_outlined,
      label: 'Transportasi',
      color: Colors.black,
    ),
    CategoryData(
      icon: Icons.favorite_outline,
      label: 'Donasi',
      color: Colors.black,
    ),

    CategoryData(
      icon: Icons.restaurant_outlined,
      label: 'Makan',
      color: Colors.black,
    ),
    CategoryData(
      icon: Icons.card_giftcard_outlined,
      label: 'Hadiah',
      color: Colors.black,
    ),
    CategoryData(
      icon: Icons.local_cafe_outlined,
      label: 'Coffee',
      color: Colors.black,
    ),
    CategoryData(
      icon: Icons.apple,
      label: 'Buah',
      color: Colors.black,
    ),
    CategoryData(
      icon: Icons.brush_outlined,
      label: 'Make Up',
      color: Colors.black,
    ),

    CategoryData(
      icon: Icons.cake_outlined,
      label: 'Birthday',
      color: Colors.black,
    ),
    CategoryData(
      icon: Icons.phone_android_outlined,
      label: 'Handphone',
      color: Colors.black,
    ),
    CategoryData(
      icon: Icons.home_outlined,
      label: 'Rumah',
      color: Colors.black,
    ),
    CategoryData(
      icon: Icons.shopping_cart_outlined,
      label: 'Belanja',
      color: Colors.black,
    ),
    CategoryData(
      icon: Icons.local_shipping_outlined,
      label: 'Kurir',
      color: Colors.black,
    ),

    CategoryData(
      icon: Icons.spa_outlined,
      label: 'Salon',
      color: Colors.black,
    ),
    CategoryData(
      icon: Icons.directions_car_outlined,
      label: 'Transportasi',
      color: Colors.black,
    ),
    CategoryData(
      icon: Icons.account_balance_outlined,
      label: 'Bank',
      color: Colors.black,
    ),
    CategoryData(
      icon: Icons.fastfood_outlined,
      label: 'Jajan',
      color: Colors.black,
    ),
    CategoryData(
      icon: Icons.pets_outlined,
      label: 'Doggy',
      color: Colors.black,
    ),

    CategoryData(
      icon: Icons.checkroom_outlined,
      label: 'Baju',
      color: Colors.black,
    ),
    CategoryData(
      icon: Icons.restaurant_menu_outlined,
      label: 'Makanan',
      color: Colors.black,
    ),
    CategoryData(
      icon: Icons.work_outline,
      label: 'Pekerjaan',
      color: Colors.black,
    ),
    CategoryData(
      icon: Icons.sports_esports_outlined,
      label: 'Game',
      color: Colors.black,
    ),
    CategoryData(
      icon: Icons.pets_outlined,
      label: 'Cat',
      color: Colors.black,
    ),

    CategoryData(
      icon: Icons.fastfood_outlined,
      label: 'Jajan',
      color: Colors.black,
    ),
    CategoryData(
      icon: Icons.face_outlined,
      label: 'Skincare',
      color: Colors.black,
    ),
    CategoryData(
      icon: Icons.shopping_bag_outlined,
      label: 'Belanja',
      color: Colors.black,
    ),
    CategoryData(
      icon: Icons.devices_outlined,
      label: 'Digi',
      color: Colors.black,
    ),
    CategoryData(
      icon: Icons.forest_outlined,
      label: 'Camp',
      color: Colors.black,
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
