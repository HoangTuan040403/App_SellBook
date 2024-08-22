  import 'package:mongo_dart/mongo_dart.dart';

  class Customer {
    String? idCus;
    String? fullNameCus;
    String? addressCus;
    String? emailCus;
    String? phoneNumCus;
    String? genderCus;
    int? rank;

    Customer({
      this.idCus,
      this.fullNameCus,
      this.addressCus,
      this.emailCus,
      this.phoneNumCus,
      this.genderCus,
      this.rank,
    });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      idCus: json['_id'] != null ? ObjectId.parse(json['_id']).toHexString() : '',
      fullNameCus: json['tenuser'],
      emailCus: json['email'],
      phoneNumCus: json['phoneNumber'],
      addressCus: json['diaChi'],
      genderCus: json['genderCus'],  
      rank: json['rank'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': idCus,
      'tenuser': fullNameCus,
      'diaChi': addressCus,
      'email': emailCus,
      'phoneNumber': phoneNumCus,
      'genderCus': genderCus,
      'rank': rank,
    };
  }
}
