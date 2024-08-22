import 'dart:convert';

import 'package:doan_cuahangbansach/data/model/ctdh.dart';
import 'package:doan_cuahangbansach/data/model/customer.dart';
import 'package:doan_cuahangbansach/data/model/donhang.dart';
import 'package:doan_cuahangbansach/data/model/giohang.dart';
import 'package:doan_cuahangbansach/page/Home/home_view.dart';
import 'package:doan_cuahangbansach/page/Orders/OderSuccess.dart';
import 'package:doan_cuahangbansach/page/cart/cartcounter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OderPro extends StatelessWidget {
  final Customer user;
  final List<GioHang> selectedCartItems;

  const OderPro({
    required this.user,
    required this.selectedCartItems,
  });
// xóa giỏ hàng sau khi thanh toán
  Future<void> deleteCartItem(String id) async {
    final String apiUrl = 'http://172.168.1.248:3000/api/cart/delete/$id';

    try {
      var response = await http.delete(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        print('Xóa sản phẩm khỏi giỏ hàng thành công');
      } else {
        print('Xóa sản phẩm khỏi giỏ hàng thất bại: ${response.body}');
        throw Exception('Failed to delete cart item');
      }
    } catch (e) {
      print('Xóa sản phẩm khỏi giỏ hàng thất bại: $e');
      throw Exception('Failed to delete cart item');
    }
  }

  // CẬP NHẬT SỐ LƯỢNG
//   Future<void> updateProItemQuantity(String idPro, int newQuantity) async {
//   final String apiUrl = 'http://172.18.48.1:3000/api/products/update/$idPro';

//   print('Đang cập nhật sản phẩm ID: $idPro, số lượng mới: $newQuantity');

//   try {
//     var response = await http.put(
//       Uri.parse(apiUrl),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode({'idPro': idPro, 'SoluongTon': newQuantity}),
//     );

//     if (response.statusCode == 200) {
//       print('Cập nhật thành công');
//     } else {
//       print('Cập nhật thất bại với mã lỗi ${response.statusCode}');
//       throw Exception(
//           'Cập nhật số lượng sản phẩm thất bại: ${response.body}');
//     }
//   } catch (e) {
//     print('Cập nhật thất bại: $e');
//     throw Exception('Cập nhật số lượng sản phẩm thất bại');
//   }
// }
  Future<void> updateProItemQuantity(String idPro, int newQuantity) async {
    final String apiUrl = 'http://172.18.48.1:3000/api/products/update/$idPro';

    print('Đang cập nhật sản phẩm ID: $idPro, số lượng mới: $newQuantity');

    try {
      var response = await http.put(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'idPro': idPro, 'SoluongTon': newQuantity}),
      );


    } catch (e) {
      print('Cập nhật thất bại: $e');
      throw Exception('Cập nhật số lượng sản phẩm thất bại');
    }
  }

  // ĐẶT HÀNG
  Future<void> placeOrder(Donhang order, List<CTDH> orderDetails) async {
    final url = Uri.parse('http://172.18.48.1:3000/api/donhang/payment');

    final orderJson = order.toJson();

    final List<Map<String, dynamic>> orderDetailsJson =
        orderDetails.map((detail) => detail.toJson()).toList();
    final Map<String, dynamic> requestData = {
      ...orderJson,
      'cartItems': orderDetailsJson,
    };
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 201) {
      print('ĐẶT HÀNG THÀNH CÔNG .');
    } else {
      print('Loior: ${response.statusCode}');
    }
  }

  double calculateTotalAmount(List<GioHang> items) {
    double totalAmount = 0;
    for (var item in items) {
      totalAmount += (item.price ?? 0) * (item.soLuong ?? 0);
    }
    return totalAmount;
  }

  //lấy thông tin sản phẩm
  Future<Map<String, dynamic>> fetchProductInfo(String id) async {
    final apiUrl = Uri.parse('http://172.18.48.1:3000/api/products/info/$id');
    try {
      var response = await http.get(
        apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load product information');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Đơn hàng',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 36,
            color: Color(0xFF4D9096),
          ),
        ),
      ),
      body: Container(
        color: const Color(0xFFE7E7E7),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    InfoUser(
                      user.emailCus!,
                      user.addressCus,
                      user.phoneNumCus!,
                      user.fullNameCus!,
                      user.idCus!,
                    ),
                    ...selectedCartItems
                        .map((item) => ProductOder(item))
                        .toList(),
                  ],
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border.fromBorderSide(
                  BorderSide(
                    color: Colors.black,
                    width: 0.5,
                    strokeAlign: BorderSide.strokeAlignCenter,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TotalOder(selectedCartItems, context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget InfoUser(
    String email,
    String? diaChi,
    String sdt,
    String name,
    String id,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFF4D9096),
            width: 2,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 1,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Thông tin người dùng: $name'),
              Text('$email | (+84) $sdt $id'),
              Text('Địa Chỉ: $diaChi'),
              const Divider(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Địa chỉ nhận hàng'),
                  const Icon(Icons.arrow_forward_ios_outlined),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ProductOder(GioHang item) {
    final NumberFormat formatter = NumberFormat('#,##0', 'en_US');
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 2,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, right: 40, left: 20),
                  child: Row(
                    children: [
                      Image.network(
                        'https://th.bing.com/th/id/OIP.8Bvucb7uRIbVBIBQfXOJmAAAAA?rs=1&pid=ImgDetMain',
                        height: 70,
                        width: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.error),
                      ),
                      const SizedBox(width: 15),
                      FutureBuilder<Map<String, dynamic>>(
                        future: fetchProductInfo(item.idPro!),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data?['TEN'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF4D9096),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.orange,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(3),
                                    child: Text(
                                      'Đổi trả 15 ngày',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${formatter.format(item.price! ?? 0)} VND',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Text(
                                      'số lượng : ${item.soLuong}',
                                      style: const TextStyle(
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget TotalOder(List<GioHang> items, BuildContext context) {
    final NumberFormat formatter = NumberFormat('#,##0', 'en_US');
    double totalAmount = calculateTotalAmount(items);
    double total = totalAmount + 30000;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Sản phẩm'),
            Text(
              '${formatter.format(totalAmount ?? 0)} VNĐ',
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Phí giao hàng'),
            Text(
              '30.000đ',
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
        const Divider(thickness: 1.0),
        const SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tổng cộng',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(
              '${formatter.format(total ?? 0)} VNĐ',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: ElevatedButton(
            onPressed: () async {
              Donhang order = Donhang(
                idCus: user.idCus,
                ngayDat: DateTime.now(),
                address: user.addressCus,
                tenUser: user.fullNameCus,
                status: DonhangStatus.dangChoXacNhan,
                thongBao: false,
                thanhTien: total.toDouble(),
                ngayNhan: null,
              );

              List<CTDH> orderDetails = [];
              for (var item in selectedCartItems) {
                await updateProItemQuantity(item.idPro!, item.soLuong!);
                orderDetails.add(CTDH(
                  idPro: item.idPro,
                  soLuong: item.soLuong.toString(),
                  thanhTien: (item.price ?? 0) * (item.soLuong ?? 0).toDouble(),
                ));
              }

              for (var element in selectedCartItems) {
                deleteCartItem(element.id!);
              }
              placeOrder(order, orderDetails);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OderSuccess()),
              );
              Provider.of<CartItemCountProvider>(context, listen: false)
                  .updateItemCountOder();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4D9096),
            ),
            child: const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Tiếp tục mua hàng',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
          )),
        ),
      ],
    );
  }
}
