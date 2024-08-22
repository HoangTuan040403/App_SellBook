 import 'package:mongo_dart/mongo_dart.dart';

class CateGorys {
  final String? id;
  final String? name;
  final String? img;

  CateGorys({
    required this.id,
    required this.name,
    required this.img,
  });

  factory CateGorys.fromJson(Map<String, dynamic> json) {
    return CateGorys(
      id: json['_id'] != null ? ObjectId.parse(json['_id']).toHexString() : '',
      name: json['TENLOAI'],
      img: json['Img'],
    );
  }
}