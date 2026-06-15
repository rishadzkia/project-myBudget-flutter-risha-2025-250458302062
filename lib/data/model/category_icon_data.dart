import 'dart:ui';

class CategoryIconData {
  final String path;
  final String label;

  CategoryIconData({required this.path, required this.label});
}

List<CategoryIconData> availableIcons = [
  CategoryIconData(path: 'assets/icons/kategori/apple.png', label: 'Buah'),
  CategoryIconData(path: 'assets/icons/kategori/cake.png', label: 'Kue'),
  CategoryIconData(path: 'assets/icons/kategori/camping.png', label: 'Camping'),
  CategoryIconData(path: 'assets/icons/kategori/cat.png', label: 'Hewan'),
  CategoryIconData(path: 'assets/icons/kategori/coffee.png', label: 'Kopi'),
  CategoryIconData(
      path: 'assets/icons/kategori/dental.png', label: 'Kesehatan Gigi'),
  CategoryIconData(path: 'assets/icons/kategori/donasi.png', label: 'Donasi'),
  CategoryIconData(path: 'assets/icons/kategori/fries.png', label: 'Fast Food'),
  CategoryIconData(path: 'assets/icons/kategori/game.png', label: 'Game'),
  CategoryIconData(path: 'assets/icons/kategori/gift.png', label: 'Hadiah'),
  CategoryIconData(
      path: 'assets/icons/kategori/hair.png', label: 'Perawatan Rambut'),
  CategoryIconData(path: 'assets/icons/kategori/homee.png', label: 'Rumah'),
  CategoryIconData(path: 'assets/icons/kategori/hp.png', label: 'Gadget'),
  CategoryIconData(path: 'assets/icons/kategori/makanan.png', label: 'Makanan'),
  CategoryIconData(path: 'assets/icons/kategori/makeup.png', label: 'Makeup'),
  CategoryIconData(path: 'assets/icons/kategori/mangkok.png', label: 'Makan'),
  CategoryIconData(path: 'assets/icons/kategori/pet.png', label: 'Peliharaan'),
  CategoryIconData(path: 'assets/icons/kategori/plus.png', label: 'Lainnya'),
  CategoryIconData(
      path: 'assets/icons/kategori/sendok_garpu.png', label: 'Restoran'),
  CategoryIconData(path: 'assets/icons/kategori/sepeda.png', label: 'Sepeda'),
  CategoryIconData(path: 'assets/icons/kategori/shirt.png', label: 'Pakaian'),
  CategoryIconData(
      path: 'assets/icons/kategori/shopping.png', label: 'Belanja'),
  CategoryIconData(
      path: 'assets/icons/kategori/shoppingBag.png', label: 'Shopping Bag'),
  CategoryIconData(
      path: 'assets/icons/kategori/skincare.png', label: 'Skincare'),
  CategoryIconData(
      path: 'assets/icons/kategori/transport.png', label: 'Transport'),
  CategoryIconData(
      path: 'assets/icons/kategori/troli.png', label: 'Supermarket'),
  CategoryIconData(
      path: 'assets/icons/kategori/truck.png', label: 'Pengiriman'),
  CategoryIconData(path: 'assets/icons/kategori/wallet.png', label: 'Dompet'),
  CategoryIconData(path: 'assets/icons/kategori/work.png', label: 'Kerja'),
];

List<Color> availableColors = [
  Color(0xFFFF4FC3),
  Color(0xFF4FC3FF),
  Color(0xFF4FFFB0),
  Color(0xFFFFB74F),
  Color(0xFFFF4F4F),
  Color(0xFF9B4FFF),
  Color(0xFF4FFF91),
  Color(0xFF209EF2),
  Color(0xFF00783B),
  Color(0xFF8A1E12),
];

String colorToHex(Color color) {
  return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
}

Color hexToColor(String? hex) {
  if (hex == null || hex.isEmpty) return const Color(0xFFFF4FC3);

  final buffer = StringBuffer();

  if (hex.length == 7) {
    buffer.write('ff');
  }

  buffer.write(hex.replaceFirst('#', ''));

  return Color(int.parse(buffer.toString(), radix: 16));
}
