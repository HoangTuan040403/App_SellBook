import 'dart:convert';
import 'dart:typed_data';
import 'package:doan_cuahangbansach/data/model/customer.dart';
import 'package:doan_cuahangbansach/data/model/giohang.dart';
import 'package:doan_cuahangbansach/page/Orders/Oder.dart';
import 'package:doan_cuahangbansach/page/Orders/deliveryaddress.dart';
import 'package:doan_cuahangbansach/page/SharePre/srfr.dart';
import 'package:doan_cuahangbansach/page/cart/cartcounter.dart';
import 'package:doan_cuahangbansach/page/cart/ing.dart';
import 'package:doan_cuahangbansach/page/conf/const.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);
  @override
  State<CartPage> createState() => _CartPageState();
}

// tính tổng tiền
double tinhTongTien(List<GioHang> cartItems) {
  double total = 0;
  for (var item in cartItems) {
    total += (item.soLuong ?? 1) * item.price!;
  }
  return total;
}

// tính tổng số lượng trong giỏ hàng
int soluongSP(List<GioHang> cartItems) {
  int count = 0;
  for (var item in cartItems) {
    count++;
  }
  return count;
}

// Xóa sản phẩm khỏi giỏ hàng
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

// Cập nhật số lượng sản phẩm tăng trong giỏ hàng
Future<void> updateCartItemQuantity(String cartId, int newQuantity) async {
  final String apiUrl = 'http://172.168.1.248:3000/api/cart/$cartId';

  print('Đang cập nhật giỏ hàng ID: $cartId, số lượng mới: $newQuantity');

  try {
    var response = await http.put(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'soLuong': newQuantity}),
    );

    if (response.statusCode == 200) {
      print('Cập nhật thành công');
    } else {
      print('Cập nhật thất bại với mã lỗi ${response.statusCode}');
      throw Exception(
          'Cập nhật số lượng sản phẩm trong giỏ hàng thất bại: ${response.body}');
    }
  } catch (e) {
    print('Cập nhật thất bại: $e');
    throw Exception('Cập nhật số lượng sản phẩm trong giỏ hàng thất bại');
  }
}

// lấy thông tin sản phẩm
Future<Map<String, dynamic>> fetchProductInfo(String id) async {
  final apiUrl = Uri.parse('http://172.168.1.248:3000/api/products/info/$id');
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
    throw Exception('Lỗi: $e');
  }
}

// Lấy danh sách sản phẩm trong giỏ hàng từ API
Future<List<GioHang>> fetchCartItems(String idCus) async {
  final String apiUrl = 'http://172.168.1.248:3000/api/cart/$idCus';

  try {
    var response = await http.get(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => GioHang.fromJson(json)).toList();
    } else {
      print('Lấy giỏ hàng thất bại: ${response.body}');
      return [];
    }
  } catch (e) {
    print('Lấy giỏ hàng thất bại: $e');
    return [];
  }
}

class _CartPageState extends State<CartPage> {
  // khai báo giỏ hàng
  late Future<List<GioHang>> cartItemsFuture;
  late CartItemCountProvider _cartItemCountProvider;

  Future<void> _loadCartItems() async {
    try {
      String? idCus = await SharedPreferencesHelper.getId();
      if (idCus != null) {
        _cartItemCountProvider.loadCartItems(idCus);
      } else {
        print('Customer ID is null.');
      }
    } catch (e) {
      print('Error loading cart items: $e');
    }
  }

  // chọn sản phẩm từ giỏ hàng
  GioHang? selectedCartItem;
  @override
  void initState() {
    super.initState();
    _cartItemCountProvider =
        Provider.of<CartItemCountProvider>(context, listen: false);
    _loadCartItems();
    _loadCustomerData();
    // lấy id từ ShareP
    cartItemsFuture = SharedPreferencesHelper.getId().then((idCus) {
      if (idCus != null) {
        return fetchCartItems(idCus);
      } else {
        throw Exception('không tìm thấy mã user');
      }
    });
  }

  // lấy thông tin người dùng
  late Customer _customer = Customer();

  String? name;
  String? address;
  String? phone;

  Future<void> _loadCustomerData() async {
    try {

      String? idCus = await SharedPreferencesHelper.getId();
      var response =
          await http.get(Uri.parse('http://172.168.1.248:3000/api/users/$idCus'));
      if (response.statusCode == 200) {
        setState(() {
          _customer = Customer.fromJson(json.decode(response.body));
          name = _customer.fullNameCus ?? 'Chưa có';
          address = _customer.addressCus ?? 'Chưa có';
          phone = _customer.phoneNumCus ?? 'Chưa có';
        });
        print('name');

        print(name);
        print('address');

        print(address);
        print('phone');

        print(phone);


      } else {
        throw Exception('Failed to load customer data');
      }
    } catch (e) {
      print('Error loading customer data: $e');
      // Handle error
    }
  }

  List<GioHang> selectedCartItems = [];

  // Hàm thêm/xóa sản phẩm được chọn
  void toggleCartItem(GioHang item) {
    setState(() {
      if (selectedCartItems.contains(item)) {
        selectedCartItems.remove(item);
      } else {
        selectedCartItems.add(item);
      }
    });
  }

  void addAllToCart(List<GioHang> items) {
    setState(() {
      selectedCartItems.addAll(items);
    });
  }

  // Hàm kiểm tra xem sản phẩm có được chọn hay không
  bool isSelected(GioHang item) {
    return selectedCartItems.contains(item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Giỏ Hàng',
          style: titleStyle,
        ),
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 4,
        shadowColor: Colors.grey,
      ),
      body: Container(
        color: const Color(0xFFE7E7E7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  color: const Color(0xFFE7E7E7),
                  padding: const EdgeInsets.all(16.0),
                  child: FutureBuilder<List<GioHang>>(
                    future: cartItemsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Lỗi: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 20),
                              Image.network(
                                'https://vitinhgiakhang.com/tp/T0213/img/tmp/cart-empty.png',
                              ),
                              const Text(
                                'Giỏ hàng trống',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        final cartItems = snapshot.data!;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 255, 0, 0),
                              ),
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                '${'Tổng tiền sản phẩm:' + tinhTongTien(cartItems).toStringAsFixed(0)} đ',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: cartItems.length,
                              itemBuilder: (context, index) {
                                final cartItem = cartItems[index];
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedCartItem = cartItem;
                                    });
                                  },
                                  child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      producgiohang(cartItem, cartItems),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
            BottonNav(),
          ],
        ),
      ),
    );
  }

  String normalizeBase64(String base64String) {
    while (base64String.length % 4 != 0) {
      base64String += '=';
    }
    return base64String;
  }

  // Widget hiển thị thông tin sản phẩm trong giỏ hàng
  Widget producgiohang(GioHang item, List<GioHang> cartItems) {
    return GestureDetector(
      onTap: () {
        toggleCartItem(item);
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Checkbox(
                  value: isSelected(item),
                  onChanged: (value) {
                    toggleCartItem(item);
                  },
                ),
                Container(
                  height: 100,
                  width: 63,
                  child: FutureBuilder<Map<String, dynamic>>(
                    future: fetchProductInfo(item.idPro!),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        try {
                          String chuoiBase64 =
                              normalizeBase64(snapshot.data?['IMG']);
                           return CachedImageWidget(
                            base64String: 'data:image/png;base64,$chuoiBase64',
                            cacheManager: ImageCacheManager(),
                          );
                        } catch (e) {
                          return Text('Error ');
                        }
                      }
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder<Map<String, dynamic>>(
                        future: fetchProductInfo(item.idPro!),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return Text(
                              snapshot.data?['TEN'] ?? '',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.orange, width: 1),
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
                        children: [
                          Container(
                            width: 90,
                            child: Text(
                              'Giá: ${item.price ?? 0} đ',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          const SizedBox(width: 30),
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  alignment: Alignment.center,
                                  child: CircleAvatar(
                                    maxRadius: 15,
                                    backgroundColor: backgroundColor,
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.remove,
                                        size: 15,
                                      ),
                                      onPressed: () async {
                                        if ((item.soLuong ?? 1) > 1) {
                                          await updateCartItemQuantity(
                                              item.id ?? '', item.soLuong! - 1);
                                          setState(() {
                                            item.soLuong =
                                                (item.soLuong ?? 1) - 1;
                                          });
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('Xác nhận'),
                                                content: const Text(
                                                    'Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng?'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text('Hủy'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: const Text('Xóa'),
                                                    onPressed: () async {
                                                      Navigator.of(context)
                                                          .pop();
                                                      await deleteCartItem(
                                                          item.id ?? '');
                                                      setState(() {
                                                        cartItems.remove(item);
                                                      });
                                                      Provider.of<CartItemCountProvider>(
                                                              context,
                                                              listen: false)
                                                          .updateItemCount(
                                                              cartItems);
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      },
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 32,
                                  height: 32,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    border: Border.symmetric(
                                      horizontal: BorderSide(
                                          color: backgroundColor, width: 1),
                                    ),
                                  ),
                                  child: Text(item.soLuong.toString()),
                                ),
                                Container(
                                  width: 32,
                                  height: 32,
                                  alignment: Alignment.center,
                                  child: CircleAvatar(
                                    maxRadius: 15,
                                    backgroundColor: backgroundColor,
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.add,
                                        size: 15,
                                      ),
                                      onPressed: () async {
                                        await updateCartItemQuantity(
                                            item.id ?? '',
                                            (item.soLuong ?? 1) + 1);
                                        setState(() {
                                          item.soLuong =
                                              (item.soLuong ?? 1) + 1;
                                        });
                                        Provider.of<CartItemCountProvider>(
                                                context,
                                                listen: false)
                                            .updateItemCount(cartItems);
                                      },
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// ignore: non_constant_identifier_names
  Widget BottonNav() {
    return Column(
      children: [
        Container(
          color: backgroundColor,
          height: 60,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.local_offer, color: Colors.black),
                    const SizedBox(width: 8.0),
                    const Text(
                      'Mã giảm giá',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    const SizedBox(width: 128.0),
                    TextButton(
                      child: const Text(
                        'Chọn mã giảm giá',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                        textAlign: TextAlign.right,
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                              height: 400,
                              child: Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('close'),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          color: textColor,
          height: 60,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Radio(value: false, groupValue: null, onChanged: null),
                    Text(
                      'chọn tất cả',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () async {
                      String? id = await SharedPreferencesHelper.getId();
                      String? emailCus =
                          await SharedPreferencesHelper.getEmail();
                      if (id != null &&
                          phone != 'Chưa có' &&
                          name != 'Chưa có' &&
                          address != 'Chưa có' &&
                          selectedCartItems.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OderPro(
                              user: Customer(
                                idCus: id,
                                fullNameCus: name,
                                emailCus: emailCus,
                                phoneNumCus: phone,
                                addressCus: address,
                              ),
                              selectedCartItems: selectedCartItems,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Vui lòng chọn sản phẩm và đảm bảo thông tin người dùng đầy đủ.'),
                          ),
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Đặt hàng (${selectedCartItems.length})',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CachedImageWidget extends StatelessWidget {
  final String base64String;
  final ImageCacheManager cacheManager;
  final double width;
  final double height;

  const CachedImageWidget({
    required this.base64String,
    required this.cacheManager,
    this.width = 63,
    this.height = 100,
  });

  @override
  Widget build(BuildContext context) {
    final String pureBase64 = base64String.split(',').last.trim();
    Uint8List? imageBytes = cacheManager.getFromCache(pureBase64);

    if (imageBytes != null) {
      return Image.memory(
        imageBytes,
        width: width,
        height: height,
        fit: BoxFit.fitHeight,
      );
    } else {
      Uint8List bytes = base64Decode(pureBase64);
      cacheManager.addToCache(pureBase64, bytes);
      return Image.memory(
        bytes,
        width: width,
        height: height,
        fit: BoxFit.fitHeight,
      );
    }
  }
}
