import 'package:mongo_dart/mongo_dart.dart';

class FavoriteCus {
  String? id;
  String? idPro;
  String? idCus;
  int? price;
 
  FavoriteCus({
    this.id,
    this.idPro,
    this.idCus,
    this.price,
   });
  factory FavoriteCus.fromJson(Map<String, dynamic> json) {
    return FavoriteCus(
      id: json['_id'] != null ? ObjectId.parse(json['_id']).toHexString() : '',
      idPro: json['idPro'],
      idCus: json['idCus'],
      price: json['giaSP'],
     );
  }
}
