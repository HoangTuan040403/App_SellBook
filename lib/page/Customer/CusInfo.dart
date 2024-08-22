import 'dart:convert';
import 'dart:ui';
import 'package:doan_cuahangbansach/data/model/customer.dart';
import 'package:doan_cuahangbansach/page/Customer/CusEditInfo.dart';
import 'package:doan_cuahangbansach/page/Customer/Gadget/MyPaymentMethod.dart';
import 'package:doan_cuahangbansach/page/Customer/Gadget/MyVoucher.dart';
import 'package:doan_cuahangbansach/page/Customer/Order/Rate/Rating.dart';
import 'package:doan_cuahangbansach/page/Login_Register/layoutLogin.dart';
import 'package:doan_cuahangbansach/page/Membership/PageMember.dart';
import 'package:doan_cuahangbansach/page/OrderDetail/mainOrder.dart';
import 'package:doan_cuahangbansach/page/SharePre/srfr.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CusInfo extends StatefulWidget {
  const CusInfo({super.key});

  @override
  _CusInfoState createState() => _CusInfoState();
}

class _CusInfoState extends State<CusInfo> {
  // Khai báo biến của người dùng
  // late Future<String?> _username;
  late Future<String?> _email;

  late Future<String?> _id;
  //lấy dữ liệu người dùng 
  late Customer _customer = Customer();
    String name = 'chưa có';
  Future<void> _loadCustomerData( Future<String?> _id) async {
    final response = await http.get(Uri.parse('http://172.18.48.1:3000/api/users/${_id}'));
    if (response.statusCode == 200) {
      setState(() {
        _customer = Customer.fromJson(json.decode(response.body));
        name = _customer.fullNameCus ?? 'chưa có';
      });
    } else {
      throw Exception('Failed to load customer');
    }
  }
  // Gán dữ liệu từ SharePreferences
  @override
  void initState() {
    super.initState();
    _email = SharedPreferencesHelper.getEmail();
    _id = SharedPreferencesHelper.getId();
  }

    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thông tin người dùng"),
                  automaticallyImplyLeading: false,  

      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Background image and blur effect
            Container(
              width: double.infinity,
              height: 220,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(80),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
                image: const DecorationImage(
                  image: AssetImage('assets/images/background.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(80),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: Container(
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
              ),
            ),

            // Centered profile section
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                          'https://www.dog-on-it-parks.com/blog/wp-content/uploads/2018/06/Sting-300x225.jpg',
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(                                                      
                        //         name,
                        //         style: const TextStyle(
                        //           fontSize: 20,
                        //           fontWeight: FontWeight.bold,
                        //           color: Colors.white,
                        //         ),
                        //         maxLines: 1,
                        //         overflow: TextOverflow.ellipsis,
                        //       ),

                        Container(
                          width: 240,
                          child: FutureBuilder<String?>(
                            future: _id,
                            builder: (context, snapshot) {
                              return Text(                                                      
                                name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              );
                            },
                          ),
                        ),

                        
                        const SizedBox(height: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FutureBuilder<String?>(
                              future: _email,
                              builder: (context, snapshot) {
                                return Text(
                                  'Email: ${snapshot.data ?? 'Email'}',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                );
                              },
                            ),
                            const Text(
                              'Số điện thoại: (+84) 9xx xxx xxx',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const Text(
                              'Địa chỉ: 828 Sư Vạn Hạnh...',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Settings button
            Positioned(
              top: 20,
              right: 10,
              child: FutureBuilder<String?>(
                future: _id,
                builder: (context, snapshot) {
                  return IconButton(
                    icon: const Icon(Icons.settings, color: Colors.white),
                    onPressed: () {
                      if (snapshot.connectionState == ConnectionState.done) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CusEditInfo(customerId: snapshot.data),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ),
            // Additional sections
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 250, 10, 10),
              child: SizedBox(
                height: 200,
                child: Orders(),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 430, 10, 10),
              child: MyGadget(),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 620, 10, 120),
              child: Support(),
            ),
          ],
        ),
      ),
    );
  }
}

//class Orders

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: ShapeDecoration(
            color: const Color(0xFFFAFAFA),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 15,
                offset: Offset(0, 0),
                spreadRadius: 0,
              )
            ],
          ),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Đơn hàng',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildOrderCard(
                    context,
                    assetPath: 'assets/icons/wait.png',
                    title: 'Chờ xác nhận',
                    destinationPage: const MainOrder(),
                  ),
                  _buildOrderCard(
                    context,
                    assetPath: 'assets/icons/box.jpg',
                    title: 'Chờ đóng hàng',
                    destinationPage: const MainOrder(),
                  ),
                  _buildOrderCard(
                    context,
                    assetPath: 'assets/icons/delivery.png',
                    title: 'Chờ giao hàng',
                    destinationPage: const MainOrder(),
                  ),
                  _buildOrderCard(
                    context,
                    assetPath: 'assets/icons/rate.png',
                    title: 'Đánh giá',
                    destinationPage: const Rating(),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOrderCard(BuildContext context,
      {required String assetPath,
      required String title,
      required Widget destinationPage}) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationPage),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 35,
            height: 35,
            child: Image.asset(
              assetPath,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

//class MyGadget

class MyGadget extends StatefulWidget {
  const MyGadget({super.key});

  @override
  State<MyGadget> createState() => _MyGadgetState();
}

class _MyGadgetState extends State<MyGadget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: ShapeDecoration(
            color: const Color(0xFFFAFAFA),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 15,
                offset: Offset(0, 0),
                spreadRadius: 0,
              )
            ],
          ),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Tiện ích của tôi',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildOrderCard(
                    context,
                    assetPath: 'assets/icons/payment.png',
                    title: 'Ví của tôi',
                    destinationPage: const MyPaymentMethod(),
                  ),
                  _buildOrderCard(
                    context,
                    assetPath: 'assets/icons/voucher.png',
                    title: 'Kho Voucher',
                    destinationPage: const MyVoucher(),
                  ),
                  _buildOrderCard(
                    context,
                    assetPath: 'assets/icons/membership.png',
                    title: 'Thẻ thành viên',
                    destinationPage: const PageMember(),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOrderCard(BuildContext context,
      {required String assetPath,
      required String title,
      required Widget destinationPage}) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationPage),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: Image.asset(
              assetPath,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

//class Support

class Support extends StatefulWidget {
  const Support({super.key});

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: ShapeDecoration(
            color: const Color(0xFFFAFAFA),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 15,
                offset: Offset(0, 0),
                spreadRadius: 0,
              )
            ],
          ),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Hỗ trợ khách hàng',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Column(
                children: [
                  _buildSupportCard(
                    assetPath: 'assets/icons/question.jpg',
                    title: 'Trung tâm trợ giúp khách hàng',
                  ),
                  _buildSupportCard(
                    assetPath: 'assets/icons/support.png',
                    title: 'Yêu cầu tư vấn',
                  ),
                  _buildSupportCard(
                    assetPath: 'assets/icons/report.png',
                    title: 'Báo cáo',
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Layoutlogin()),
                        );
                      },
                      child: const Text('Đăng Xuất tài khoản')),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSupportCard({required String assetPath, required String title}) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            height: 50,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: Colors.black.withOpacity(0.5),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    assetPath,
                    width: 30,
                    height: 30,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
