import 'dart:convert';
import 'package:doan_cuahangbansach/data/model/donhang.dart';
import 'package:doan_cuahangbansach/data/model/oder.dart';
import 'package:doan_cuahangbansach/item/ItemOrder.dart';
import 'package:doan_cuahangbansach/page/OrderDetail/mainOrder.dart';
import 'package:doan_cuahangbansach/page/SharePre/srfr.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ThongBao extends StatefulWidget {
  const ThongBao({super.key});

  @override
  State<ThongBao> createState() => _DonhangHuyState();
}

class _DonhangHuyState extends State<ThongBao> {
  late Future<String?> _id;

  @override
  void initState() {
    super.initState();
    _getIdFromSharedPreferences();
     setState(() {});

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
  
 



Future<void> updateThongBao(String orderId) async {
  final String apiUrl = 'http://192.168.2.14:3000/api/donhang/thongbao/$orderId';

  try {
    var response = await http.put(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'thongBao': true}),
    );

    if (response.statusCode == 200) {
      print('Cập nhật thông báo thành công');
       setState(() {});
    } else {
      print('Failed to update notification with status code ${response.statusCode}');
      throw Exception('Failed to update notification');
    }
  } catch (e) {
    print('Error updating notification: $e');
    throw Exception('Failed to update notification');
  }
}


  Future<List<Donhang>> fetchDonhangs(String idCus) async {
    var url = Uri.parse('http://192.168.2.14:3000/api/donhang/thongbao/$idCus');
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
      appBar: AppBar(
        title: const Text(
          'Thông báo',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 32,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF4D9194),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.message_sharp,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
                                          color: Color.fromARGB(255, 255, 255, 255),

          child: FutureBuilder<String?>(
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
                  future: fetchDonhangs(idCus),
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
                        child: Column(
                          children: [
                            NotificationSection(),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: orders.length,
                              itemBuilder: (context, index) {
                                return OrderUpdateTile(context, orders[index]);
                              },
                            ),
                          ],
                        ),
                      );
                    }
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }

Widget OrderUpdateTile(BuildContext context, Donhang item) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const MainOrder(),
        ),
      );
    },
    child: Column(
      children: [
        Text("Mã đơn hàng: ${item.id ?? 'N/A'}"),
        Card(
          color: const Color.fromARGB(255, 176, 176, 180),
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: ListTile(
            leading: Image.network(
                'https://salt.tikicdn.com/ts/product/3b/91/f4/4f4e795d7be736c9e05529d4ac6ff728.jpg'),
            title: const Text('Giao hàng thành công',
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text(
                'Sách của bạn đã được giao thành công\nVui lòng xác nhận đơn hàng và đánh giá',
                style: TextStyle(color: Colors.white)),
           trailing: ElevatedButton(
              onPressed: () {
                updateThongBao(item.id!);
              },
              child: Text('Xác nhận'),
            ),
          ),
        ),
      ],
    ),
  );
}
}




class NotificationSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NotificationTile(
          icon: Icons.local_offer,
          iconColor: Colors.orange,
          title: 'Khuyến mãi',
          subtitle: 'Các mã khuyến mãi hấp dẫn đang chờ bạn!',
        ),
        NotificationTile(
          icon: Icons.access_time,
          iconColor: const Color.fromARGB(255, 233, 212, 15),
          title: 'Khung giờ vàng',
          subtitle: 'Các sản phẩm ưu đãi đang chờ bạn!!!',
        ),
        NotificationTile(
          icon: Icons.card_giftcard,
          iconColor: Colors.lightGreen,
          title: 'Phần thưởng hấp dẫn',
          subtitle: 'Tham gia sự kiện nhận quà liền tay!!!',
        ),
        const SizedBox(
          height: 6,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 16,
            ),
            Text(
              'Cập nhật đơn hàng',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        )
      ],
    );
  }
}

class NotificationTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  NotificationTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade400)),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: iconColor.withOpacity(0.2),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 1, 20, 48),
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
        onTap: () {},
      ),
    );
  }
}
