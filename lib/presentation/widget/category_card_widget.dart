import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../page/utama/kategori_page.dart';

class KategoriData {
  final IconData icon;
  final String label;
  final Color iconColor;

  KategoriData({
    required this.icon,
    required this.label,
    required this.iconColor,
  });
}

class CardCategory extends StatelessWidget {
  final VoidCallback? onTap;
  const CardCategory({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final List<KategoriData> categories = [
      KategoriData(
        icon: Icons.category_outlined,
        label: 'Belanja',
        iconColor: Color.fromARGB(255, 0, 0, 0),
      ),
      KategoriData(
        icon: Icons.fastfood_rounded,
        label: 'Makanan',
        iconColor: Color.fromARGB(255, 0, 0, 0),
      ),
      KategoriData(
        icon: Icons.coffee_rounded,
        label: 'Coffe',
        iconColor: Color.fromARGB(255, 0, 0, 0),
      ),
      KategoriData(
        icon: Icons.directions_car_outlined,
        label: 'Transportasi',
        iconColor: Color.fromARGB(255, 0, 0, 0),
      ),
      KategoriData(
        icon: Icons.add_rounded,
        label: 'Lainnya',
        iconColor: Color.fromARGB(255, 0, 0, 0),
      ),
    ];
    return Row(
      children: categories.map((item) {
        return KategoriItem(
          icon: item.icon,
          label: item.label,
          onTap: item.label == 'Lainnya'
              ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CategoryPage()),
                  );
                }
              : onTap,
          iconColor: item.iconColor,
        );
      }).toList(),
    );
  }
}

class KategoriItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Color? iconColor;

  const KategoriItem(
      {super.key,
      required this.icon,
      required this.label,
      this.onTap,
      this.iconColor});

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
                    icon,
                    color: iconColor,
                    size: 28,
                  )),
              SizedBox(height: 6),
              Text(label,
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
