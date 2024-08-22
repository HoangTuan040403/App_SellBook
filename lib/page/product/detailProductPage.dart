import 'package:doan_cuahangbansach/data/model/nxb.dart';
import 'package:doan_cuahangbansach/data/model/product.dart';
import 'package:doan_cuahangbansach/item/itemPro.dart';
import 'package:doan_cuahangbansach/page/SharePre/srfr.dart';
import 'package:doan_cuahangbansach/page/cart/cartcounter.dart';
import 'package:doan_cuahangbansach/page/conf/const.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
 
 
class DetailProduct extends StatefulWidget {
  final Product product;

  const DetailProduct({Key? key, required this.product}) : super(key: key);

  @override
  State<DetailProduct> createState() => _DetailProductState();
}
void showNotification() {
  Fluttertoast.showToast(
    msg: 'Đã thêm vào giỏ hàng',
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 1,
    backgroundColor: const Color.fromARGB(255, 165, 165, 165),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
// thêm sản phẩm vào giỏ hàng
  Future<void> addCart(String idPro, String idCus, int count, int price) async {
  final String apiUrl = 'http://172.168.1.248:3000/api/cart';  
  Map<String, dynamic> user = {
        'idPro': idPro.trim(),
        'idCus': idCus.trim(),
        'giaSP': price,
        'soLuong': count,
   };

  try {
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user),
    );

    if (response.statusCode == 201) {
      print('giỏ hàng thêm thành công');
    } else {
      print('thêm giỏ hàng thất bại: ${response.body}');
    }
  } catch (e) {
    print('thêm giỏ hàng thất bại: $e');
  }
}
// LẤY THÔNG TIN NHÀ XB
void getNameNXB(String id) {
  
  String publisherName = findPublisherNameById(id);

  if (publisherName.isNotEmpty) {
    print('Tên nhà xuất bản có _id $id là: $publisherName');
  } else {
    print('Không tìm thấy nhà xuất bản có _id $id');
  }
}

class _DetailProductState extends State<DetailProduct> {
  @override
  Widget build(BuildContext context) {
     var media = MediaQuery.of(context).size;
    //lấy thông tin mã sản phẩm
    String idPro = widget.product.id!;
    int count = 1;
    int pricePro = widget.product.price!;
    String nameNXB = findPublisherNameById(widget.product.maNXB!);
    final NumberFormat formatter = NumberFormat('#,##0', 'en_US');
    String chuoiBase64 = normalizeBase64(widget.product.img ?? '');
    Uint8List imageBytes = base64Decode(chuoiBase64);
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Stack(
                          children: [
                            Image.memory(
                              imageBytes,
                              width: MediaQuery.of(context).size.width,
                              height:300,
                              fit: BoxFit.fill,
                            ),
                            Positioned(
                              top: 20,
                              left: 20,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(
                                  Icons.arrow_back,
                                  color: Color.fromARGB(255, 241, 241, 241),
                                  size: 32,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                            color: const Color(0xFFC1D6CF),
                            borderRadius: BorderRadius.circular(0)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.product.name ?? ' ',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Row(
                                      children: List.generate(
                                        5,
                                        (index) => const Icon(
                                          Icons.star,
                                          size: 14,
                                          color: Colors.orange,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 4),
                                const Text('5/5'),
                                const SizedBox(
                                  width: 4,
                                ),
                                const Text('(Đã bán 30)'),
                              ],
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                CustomButton(
                                  color: const Color.fromARGB(255, 243, 155, 114),
                                  icon: Icons.bookmark_outline,
                                  text: 'Đổi trả 30 ngày',
                                ),
                                const SizedBox(width: 12),
                                CustomButton(
                                    color:
                                        const Color.fromARGB(255, 157, 157, 162),
                                    icon: Icons.check_circle,
                                    text: '100% Chính hãng')
                              ],
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                Text(
                                  '${formatter.format(widget.product.price ?? 0)} VND',
                                  style: const TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${formatter.format(widget.product.price ?? 0)} VND',
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 4),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Số trang',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(
                                  width: 250,
                                ),
                                Text('210',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                              Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Nhà Xuất bản',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  width: 200,
                                ),
                                Text(nameNXB,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    )
                                   )
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                              Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Số Lượng còn',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(
                                  width: 250,
                                ),
                                Text(
                                '${formatter.format(widget.product.soLuongTon ?? 0)} ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            const Row(
                              children: [
                                Text(
                                  'Mô tả',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [Text(widget.product.des ?? '')],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Container(
                              color: Colors.grey,
                              height: 2,
                            ),
                            const Row(
                              children: [
                                Text(
                                  'Sản phẩm liên quan',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(children: [
                              CardProduct(),
                              const SizedBox(
                                width: 12,
                              ),
                              CardProduct(),
                            ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: FutureBuilder<String?>(
                      future: SharedPreferencesHelper.getId(),
                      builder: (BuildContext context,
                          AsyncSnapshot<String?> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData || snapshot.data == null) {
                          return const Center(child: Text('No user ID found'));
                        } else {
                          String idCus = snapshot.data!;
                          return ElevatedButton.icon(
                            onPressed: () {
                              if(widget.product.soLuongTon == null){                              
                              showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor:
                                        Colors.black.withOpacity(0.3),
                                    content: Opacity(
                                      opacity: 1,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextButton(
                                            child: const Text(
                                                'Sản phẩm đã hết hàng',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                              }else{
                                  addCart(idPro, idCus, count, pricePro);
                              Provider.of<CartItemCountProvider>(context,
                                      listen: false)
                                  .updateItemCountDetail();
                                     showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor:
                                        Colors.black.withOpacity(0.3),
                                    content: Opacity(
                                      opacity: 1,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextButton(
                                            child: const Text(
                                                'Đã thêm vào giỏ hàng',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                              }
                             
                            },
                            label: const Text(
                              'Thêm vào giỏ hàng',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            icon: const Icon(Icons.shopping_cart),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white, 
                              foregroundColor:
                                  const Color(0xFF4D9194), // Text color
                              padding: const EdgeInsets.only(top: 19, bottom: 19),
                              textStyle: const TextStyle(fontSize: 16),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.zero, 
                              ),
                              side: const BorderSide(
                                  color: Color(0xFF4D9194), width: 2),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Buy now action
                    },
                    child: const Text(
                      'Mua ngay',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4D9194),
                      // Background color
                      foregroundColor: Colors.white, // Text color
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 22),
                      textStyle: const TextStyle(fontSize: 16),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // Make corners square
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;

  CustomButton({
    required this.color,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 14),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(fontSize: 12, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class CardProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(offset: Offset(0, 0), color: Colors.grey, blurRadius: 10)
      ]),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: const BorderSide(color: Color(0xFF4D9194)),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10.0)),
                  child: Image.network(
                    'https://salt.tikicdn.com/ts/product/3b/91/f4/4f4e795d7be736c9e05529d4ac6ff728.jpg',
                    height: 150,
                    width: double.infinity,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Công Thức Tự Tin - Để Vươn Tới Sự Tự Lập'),
                      const SizedBox(height: 4),
                      const Text(
                        '130.000 VND',
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        '104.000 VND',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Row(
                                children: List.generate(
                                  5,
                                  (index) => const Icon(
                                    Icons.star,
                                    size: 14,
                                    color: Colors.orange,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          const Icon(
                            Icons.card_travel_outlined,
                            color: Color(0xFF4D9194),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF4D9194),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  '-20%',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
