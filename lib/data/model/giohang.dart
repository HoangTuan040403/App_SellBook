import 'package:mongo_dart/mongo_dart.dart';

class GioHang {
  String? id;
  String? idPro;
  String? idCus;
  int? price;
  int? soLuong;

  GioHang({
    this.id,
    this.idPro,
    this.idCus,
    this.price,
    this.soLuong,
  });
  factory GioHang.fromJson(Map<String, dynamic> json) {
    return GioHang(
      id: json['_id'] != null ? ObjectId.parse(json['_id']).toHexString() : '',
      idPro: json['idPro'],
      idCus: json['idCus'],
      price: json['giaSP'],
      soLuong: json['soLuong'],
    );
  }
}
