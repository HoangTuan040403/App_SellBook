import 'dart:convert';
import 'package:doan_cuahangbansach/data/model/donhang.dart';
import 'package:doan_cuahangbansach/item/ItemOrder.dart';
import 'package:doan_cuahangbansach/page/Orders/0derDetail.dart';
import 'package:doan_cuahangbansach/page/SharePre/srfr.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DonhangHuy extends StatefulWidget {
  const DonhangHuy({super.key});

  @override
  State<DonhangHuy> createState() => _DonhangHuyState();
}

class _DonhangHuyState extends State<DonhangHuy> {
  late Future<String?> _id;

  @override
  void initState() {
    super.initState();
    _getIdFromSharedPreferences();
  }

  Future<void> _getIdFromSharedPreferences() async {
    _id = SharedPreferencesHelper.getId();
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

  Future<List<Donhang>> fetchDonhangs(
      String idCus, bool daGiao, bool daHuy, bool dangChoXacNhan) async {
    var url = Uri.parse(
        'http://172.168.1.248:3000/api/donhang/payment/$idCus?daGiao=$daGiao&daHuy=$daHuy&dangChoXacNhan=$dangChoXacNhan');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);

      List<Donhang> donhangs = jsonList.map((json) {
        DateTime? ngayDat =
            json['ngayDat'] != null ? DateTime.tryParse(json['ngayDat']) : null;
        DateTime? ngayNhan = json['ngayNhan'] != null
            ? DateTime.tryParse(json['ngayNhan'])
            : null;

        return Donhang(
          id: json['_id'],
          idCus: json['idCus'],
          ngayDat: ngayDat,
          ngayNhan: ngayNhan,
          idPro: json['idPro'],
          status: _parseStatus(json['status']),
          address: json['address'],
          tenUser: json['tenUser'],
          thongBao: json['thongBao'],
          thanhTien: (json['thanhTien'] ?? 0).toDouble(),
        );
      }).toList();

      return donhangs;
    } else {
      throw Exception('tải thất bại');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
      body: FutureBuilder<String?>(
        future: _id,
        builder: (context, idSnapshot) {
          if (idSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (idSnapshot.hasError) {
            return Center(child: Text('Error: ${idSnapshot.error}'));
          } else if (!idSnapshot.hasData || idSnapshot.data!.isEmpty) {
            return Center(child: Text('No customer ID found'));
          } else {
            String idCus = idSnapshot.data!;
            return FutureBuilder<List<Donhang>>(
              future: fetchDonhangs(idCus, false, true, false),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                      child: Column(
                    children: [
                      Image.network(
                          'https://th.bing.com/th/id/OIP.KHgLzsvgkcl8wsWTjSHYpwHaHa?w=187&h=187&c=7&r=0&o=5&dpr=1.4&pid=1.7'),
                      Text('Chưa có thông tin đơn hàng'),
                    ],
                  ));
                } else {
                  List<Donhang> orders = snapshot.data!;
                  return SingleChildScrollView(
                    child: Container(
                      color: const Color(0xFFE7E7E7),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          final itemPro = snapshot.data![index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OrderDetailView(
                                      dh: itemPro,
                                      customerName: idCus,
                                      status: OrderStatus.cancel),
                                ),
                              );
                            },
                            child: itemOrder(orders[index]),
                          );
                        },
                      ),
                    ),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
