class RekeningModel {
  final int id;
  final String nama;
  final String symbol;
  final int iconBgColor;
  final double saldo;

  RekeningModel(
      {required this.id,
      required this.nama,
      required this.symbol,
      required this.iconBgColor,
      required this.saldo});

  factory RekeningModel.fromJson(Map<String, dynamic> json) {
    return RekeningModel(
      id: json['id'],
      nama: json['nama'],
      symbol: json['symbol'] ?? '🏛️',
      iconBgColor: json['icon_bg_color'] ?? 0xFF1565C0,
      saldo: double.tryParse(json['saldo'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama': nama,
        'symbol': symbol,
        'icon_bg_color': iconBgColor,
        'saldo': saldo,
      };
}
