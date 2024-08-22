// ignore: file_names
import 'package:doan_cuahangbansach/data/model/voucher.dart';
import 'package:flutter/material.dart';


class MyVoucher extends StatefulWidget {
  const MyVoucher({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyVoucherState createState() => _MyVoucherState();
}

class _MyVoucherState extends State<MyVoucher> {

  static List<Voucher> vouchers = [
    Voucher(
      titleVoucher: 'Discount 20%',
      valueVoucher: 20 / 100,
      descVoucher: 'Đơn tối thiểu 100.000 \n Hiệu lực sau: Còn 10 giờ',
    ),
    Voucher(
      titleVoucher: 'Discount 30%',
      valueVoucher: 30 / 100,
      descVoucher: 'Đơn tối thiểu 200.000 \n Hiệu lực sau: Còn 5 giờ',
    ),
    Voucher(
      titleVoucher: 'Discount 15%',
      valueVoucher: 15 / 100,
      descVoucher: 'Đơn tối thiểu 150.000 \n Hiệu lực sau: Còn 7 giờ',
    ),
    Voucher(
      titleVoucher: 'Discount 50%',
      valueVoucher: 50 / 100,
      descVoucher: 'Đơn tối thiểu 300.000 \n Hiệu lực sau: Còn 3 giờ',
    ),
    Voucher(
      titleVoucher: 'Discount 10%',
      valueVoucher: 10 / 100,
      descVoucher: 'Đơn tối thiểu 50.000 \n Hiệu lực sau: Còn 12 giờ',
    ),
    Voucher(
      titleVoucher: 'Discount 20%',
      valueVoucher: 20 / 100,
      descVoucher: 'Đơn tối thiểu 180.000 \n Hiệu lực sau: Còn 8 giờ',
    ),
    Voucher(
      titleVoucher: 'Discount 25%',
      valueVoucher: 25 / 100,
      descVoucher: 'Đơn tối thiểu 180.000 \n Hiệu lực sau: Còn 8 giờ',
    ),
    Voucher(
      titleVoucher: 'Discount 5%',
      valueVoucher: 5 / 100,
      descVoucher: 'Đơn tối thiểu 180.000 \n Hiệu lực sau: Còn 8 giờ',
    ),
    Voucher(
      titleVoucher: 'Discount 15%',
      valueVoucher: 15 / 100,
      descVoucher: 'Đơn tối thiểu 180.000 \n Hiệu lực sau: Còn 8 giờ',
    ),
    Voucher(
      titleVoucher: 'Discount 50%',
      valueVoucher: 25 / 100,
      descVoucher: 'Đơn tối thiểu 180.000 \n Hiệu lực sau: Còn 8 giờ',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách mã giảm giá"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFE7E7E7),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 206.37,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x66000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      ),
                    ],
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/voucher.avif',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 206.37,
                  padding: const EdgeInsets.only(top: 60, bottom: 20),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm voucher...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: vouchers.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    child: VoucherItem(
                      voucherModel: vouchers[index],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VoucherItem extends StatelessWidget {
  final Voucher voucherModel;

  const VoucherItem({super.key, required this.voucherModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          voucherModel.titleVoucher!,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Text(
              '${(voucherModel.valueVoucher! * 100).toStringAsFixed(0)}%',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 5),
            Text(
              voucherModel.descVoucher!,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () {
            // Xử lý khi nhấn nút Lưu
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4D9194),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            'Lưu',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
