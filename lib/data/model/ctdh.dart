import 'package:mongo_dart/mongo_dart.dart';

class CTDH {
  String? id;
  String? idDH;
  String? idPro;
  String? soLuong;
  double? thanhTien;

  CTDH({
    this.id,
    this.idDH,
    this.idPro,
    this.soLuong,
    this.thanhTien,
  });

  factory CTDH.fromJson(Map<String, dynamic> json) {
    return CTDH(
      id: json['_id'] != null ? ObjectId.parse(json['_id']).toHexString() : '',
      idDH: json['idDH'],
      idPro: json['idPro'],
      soLuong: json['soLuong'],
      thanhTien: json['thanhTien'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'idDH': idDH,
      'idPro': idPro,
      'soLuong': soLuong,
      'thanhTien': thanhTien,
    };
  }
}
