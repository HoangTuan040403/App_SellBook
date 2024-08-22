// ignore: file_names
import 'package:doan_cuahangbansach/data/model/donhang.dart';
 import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
  Widget itemOrder(Donhang order) {
    final NumberFormat formatter = NumberFormat('#,##0', 'en_US');
    String formattedNgayDat = DateFormat('yyyy-MM-dd HH:mm:ss').format(order.ngayDat!);

    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Card(
        elevation: 5,
        shadowColor: Colors.grey,
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFF3E4154),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: const Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Giao hàng thành công',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Text(
                      'Viết đánh giá',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image.network(
                    'https://th.bing.com/th/id/OIP.qn2ZoH7zzBHc3PkhKrj9gAAAAA?w=328&h=166&c=7&r=0&o=5&dpr=1.4&pid=1.7',
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formattedNgayDat,
                          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${formatter.format(order.thanhTien ?? 0)} VND',
                        ),
                      ],
                    ),
                  ),
                  iconTrangThai(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle navigate to detail screen
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 3,
                        shadowColor: Colors.grey,
                        backgroundColor: const Color(0XFFC4C4C4),
                      ),
                      child: const Text(
                        'Xem Chi Tiết',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle buy again action
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 4,
                        shadowColor: Colors.grey,
                        backgroundColor: const Color(0xFF4D9194),
                      ),
                      child: const Text(
                        'Mua Lại',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget iconTrangThai() {
    return Column(
      children: [
        SizedBox(
          width: 50,
          height: 50,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: const ShapeDecoration(
                    color: Colors.white,
                    shape: OvalBorder(
                      side: BorderSide(width: 1, color: Color(0xFFFF0202)),
                    ),
                  ),
                ),
              ),
              const Positioned(
                left: 5,
                top: 11,
                child: SizedBox(
                  width: 45,
                  height: 26,
                  child: Text(
                    'Giao',
                    style: TextStyle(
                      color: Color(0xFFFF0000),
                      fontSize: 18,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  
}
