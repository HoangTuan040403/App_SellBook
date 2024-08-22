import 'dart:convert';
import 'package:doan_cuahangbansach/data/model/donhang.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

// Enum cho các trạng thái đơn hàng
enum OrderStatus { confirm, delivery, packing, completed, cancel }

class OrderDetailView extends StatelessWidget {
  final String customerName;
  final Donhang dh;
  final OrderStatus status;

  const OrderDetailView({
    super.key,
    required this.dh,
    required this.customerName,
    required this.status,
  });

  // Hàm để xây dựng Card trạng thái
  Widget buildStatusCard(OrderStatus status) {
    String statusText;
    String descriptionText;
    IconData statusIcon;
    Color statusColor;

    switch (status) {
      case OrderStatus.confirm:
        statusText = "Đang chờ xác nhận";
        descriptionText = "Đơn hàng đang chờ xác nhận từ nhân viên cửa hàng";
        statusIcon = Iconsax.clock;
        statusColor = Colors.blue;
        break;
      case OrderStatus.delivery:
        statusText = "Đang giao hàng";
        descriptionText = "Đơn hàng đang trong quá trình giao hàng";
        statusIcon = Iconsax.truck_fast;
        statusColor = Colors.orange;
        break;
      case OrderStatus.packing:
        statusText = "Đang đóng gói";
        descriptionText = "Đơn hàng đang được đóng gói";
        statusIcon = Iconsax.box;
        statusColor = Colors.yellow[700]!;
        break;
      case OrderStatus.completed:
        statusText = "Hoàn thành";
        descriptionText = "Đơn hàng đã được giao thành công";
        statusIcon = Iconsax.tick_circle;
        statusColor = Colors.green;
        break;
      case OrderStatus.cancel:
        statusText = "Đã hủy";
        descriptionText = "Đơn hàng đã bị hủy";
        statusIcon = Iconsax.close_circle;
        statusColor = Colors.red;
        break;
      default:
        statusText = "";
        descriptionText = "";
        statusIcon = Icons.help;
        statusColor = Colors.grey;
        break;
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              statusText,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Text(
              descriptionText,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        tileColor: statusColor.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        leading: Icon(
          statusIcon,
          color: statusColor,
          size: 40,
        ),
      ),
    );
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

  // lấy danh sách chi tiết đơn hàng thông qua id
  // lấy thông tin sản phẩm

  @override
  Widget build(BuildContext context) {
    String ngayDat = dh.ngayDat != null
        ? DateFormat('yyyy-MM-dd HH:mm:ss').format(dh.ngayDat!)
        : 'N/A';
    String? id = dh.id;
    String address = dh.address ?? 'N/A';
    double? thanhTien = dh.thanhTien?.toDouble() ?? 0;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Order Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Đơn hàng #",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              id!,
                            ),
                          ],
                        ),
                        Icon(
                          getStatusIcon(status),
                          color: getStatusColor(status),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Chi tiết đơn hàng",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const Divider(color: Colors.grey),
                    Text(
                      "Ngày đặt hàng: $ngayDat",
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      "Khách hàng: $customerName",
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    buildStatusCard(status), // Sử dụng buildStatusCard
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Thông tin vận chuyển",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Divider(color: Colors.grey),
                    Text(
                      "Địa chỉ gửi hàng",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      "Nguyễn Hữu Toàn\n(+84) 9xx xxx xxx\n806 QL22, ấp Mỹ Hòa 3, Hóc Môn...",
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Địa chỉ nhận hàng",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      address,
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Thông tin sản phẩm",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Divider(color: Colors.grey),
                    buildProductItem(
                      "Mã sản phẩm 1",
                      "Giá: 100,000đ",
                      "assets/products/img_1.jpg",
                    ),
                    const SizedBox(height: 10),
                    buildProductItem(
                      "Mã sản phẩm 2",
                      "Giá: 200,000đ",
                      "assets/products/img_2.jpg",
                    ),
                    const SizedBox(height: 10),
                    buildProductItem(
                      "Mã sản phẩm 3",
                      "Giá: 300,000đ",
                      "assets/products/img_3.jpg",
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Chi tiết thanh toán",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Divider(color: Colors.grey),
                    buildPriceDetail("Tiền đơn giá", "600,000đ"),
                    const SizedBox(height: 10),
                    buildPriceDetail("Phí vận chuyển", "50,000đ"),
                    const SizedBox(height: 10),
                    buildPriceDetail("Giảm giá voucher", "-50,000đ"),
                    const SizedBox(height: 10),
                    const Divider(color: Colors.grey),
                    buildPriceDetail(
                        "Thành tiền", "${thanhTien.toStringAsFixed(0)}đ",
                        isTotal: true),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildProductItem(String name, String price, String imagePath) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          imagePath,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(name,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
      subtitle:
          Text(price, style: const TextStyle(fontSize: 14, color: Colors.grey)),
    );
  }

  Widget buildPriceDetail(String title, String amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colors.teal : Colors.black,
          ),
        ),
      ],
    );
  }

  // Hàm để lấy biểu tượng cho từng trạng thái
  IconData? getStatusIcon(OrderStatus status) {
    switch (status) {
      case OrderStatus.confirm:
        return Iconsax.clock;
      case OrderStatus.delivery:
        return Iconsax.truck_fast;
      case OrderStatus.packing:
        return Iconsax.box;
      case OrderStatus.completed:
        return Iconsax.tick_circle;
      case OrderStatus.cancel:
        return Iconsax.close_circle;
      default:
        return null; // Biểu tượng mặc định nếu không phù hợp
    }
  }

  // Hàm để lấy màu sắc cho từng trạng thái
  Color getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.confirm:
        return Colors.blue;
      case OrderStatus.delivery:
        return Colors.orange;
      case OrderStatus.packing:
        return Colors.yellow[700]!;
      case OrderStatus.completed:
        return Colors.green;
      case OrderStatus.cancel:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // Hàm để chuyển đổi trạng thái sang dạng chuỗi
  String getStatusString(OrderStatus status) {
    switch (status) {
      case OrderStatus.confirm:
        return "Đơn hàng đang chờ xác nhận";
      case OrderStatus.delivery:
        return "Đơn hàng đang được giao";
      case OrderStatus.packing:
        return "Đơn hàng đang được đóng gói";
      case OrderStatus.completed:
        return "Hoàn thành";
      case OrderStatus.cancel:
        return "Đơn hàng đã được hủy";
      default:
        return "";
    }
  }
}

 
