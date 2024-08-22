import 'package:mongo_dart/mongo_dart.dart';

enum DonhangStatus {
  daGiao,
  daHuy,
  dangChoXacNhan,
}

class Donhang {
  String? id;
  String? idCus;
  DateTime? ngayDat;
  DateTime? ngayNhan;
   String? idPro;
  DonhangStatus? status;
  String? address;
  String? tenUser;
  bool? thongBao;
  double? thanhTien;

  Donhang({
    this.id,
    this.idCus,
    this.ngayDat,
    this.ngayNhan,
     this.idPro,
    this.status,
    this.address,
    this.tenUser,
    this.thongBao,
    this.thanhTien,
  });

  factory Donhang.fromJson(Map<String, dynamic> json) {
    return Donhang(
    id: json['_id'] != null ? ObjectId.parse(json['_id']).toHexString() : '',
      idCus: json['idCus'],
      ngayDat: DateTime.parse(json['ngayDat']),
      ngayNhan: DateTime.parse(json['ngayNhan']),
       idPro: json['idPro'],
      status: _parseStatus(json['status']),
      address: json['address'],
      tenUser: json['tenUser'],
      thongBao: json['thongBao'],
      thanhTien: json['thanhTien'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'idCus': idCus,
      'ngayDat': ngayDat?.toIso8601String(),
      'ngayNhan': ngayNhan?.toIso8601String(),  
      'idPro': idPro,
      'status': _statusToString(status),
      'address': address,
      'tenUser': tenUser,
      'thongBao': thongBao,
      'thanhTien': thanhTien,
    };
  }

  static DonhangStatus? _parseStatus(String? statusString) {
    if (statusString == null) return null;
    switch (statusString) {
      case 'daGiao':
        return DonhangStatus.daGiao;
      case 'daHuy':
        return DonhangStatus.daHuy;
      case 'dangChoXacNhan':
        return DonhangStatus.dangChoXacNhan;
      default:
        return null;
    }
  }

  static String? _statusToString(DonhangStatus? status) {
    if (status == null) return null;
    switch (status) {
      case DonhangStatus.daGiao:
        return 'daGiao';
      case DonhangStatus.daHuy:
        return 'daHuy';
      case DonhangStatus.dangChoXacNhan:
        return 'dangChoXacNhan';
      default:
        return null;
    }
  }
}
