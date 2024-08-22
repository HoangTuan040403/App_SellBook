import 'package:mongo_dart/mongo_dart.dart';

class Product {
  String? id;
  String? name;
  String? des;
  String? img;
  String? img2;
  String? img3;
  String? img4;
  int? price;
  String? categoryID;
  int? soLuongTon;
  int? soLuongGG;
  String? maNXB;
  Product({
    this.id,
    this.name,
    this.des,
    this.img,
    this.img2,
    this.img3,
    this.img4,
    this.price,
    this.categoryID,
    this.soLuongGG,
    this.soLuongTon,
    this.maNXB,
    });
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'] != null ? ObjectId.parse(json['_id']).toHexString() : '',
      name: json['TEN'],
      img: json['IMG'],
      img2: json['Hinh_2'],
      img3: json['Hinh_3'],
      img4: json['Hinh_4'],
      des: json['DES'],
       price: json['PRICE'],
      categoryID: json['CateID'],
      soLuongGG: json['SoLuongGG'],
      soLuongTon: json['SoluongTon'],
      maNXB: json['MaNXB']
    );
  }
}
