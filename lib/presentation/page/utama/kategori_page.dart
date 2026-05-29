import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryPage extends StatelessWidget {
  CategoryPage({super.key});

  final List<CategoryData> categories = [
    CategoryData(
        icon: Icons.category_outlined, label: 'Belanja', color: Colors.blue),
    CategoryData(
        icon: Icons.fastfood_rounded, label: 'Makanan', color: Colors.orange),
    CategoryData(
        icon: Icons.coffee_rounded, label: 'Coffe', color: Colors.brown),
    CategoryData( 
        icon: Icons.directions_car_outlined,
        label: 'Transportasi',
        color: Colors.green),
    CategoryData(icon: Icons.add_rounded, label: 'Lainnya', color: Colors.grey),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class CategoryData {
  final IconData icon;
  final String label;
  final Color? color;

  CategoryData({required this.icon, required this.label, required this.color});
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
                      color: Colors.white,
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
                    color: data.color,
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
