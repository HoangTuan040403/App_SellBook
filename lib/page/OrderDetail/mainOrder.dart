import 'package:flutter/material.dart';

import 'package:doan_cuahangbansach/page/OrderDetail/Donhanghuy.dart';
import 'package:doan_cuahangbansach/page/OrderDetail/Donhangnhan.dart';
import 'package:doan_cuahangbansach/page/OrderDetail/Donhangxacnhan.dart';
import 'package:doan_cuahangbansach/page/OrderDetail/Search.dart';

class MainOrder extends StatefulWidget {
  const MainOrder({super.key});

  @override
  _MainOrderState createState() => _MainOrderState();
}

class _MainOrderState extends State<MainOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: const Color(0xFF4D9194),
            title: const Text(
              'Đơn hàng của tôi',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15),
              ),
            ),
          ),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Container(
              color: Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: 'Nhập tên mã đơn hàng...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.7),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SearchOrder(),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    // các trang trạng thái đơn hàng
                    child: const TabBar(
                      indicatorColor: Color(0XFF4D9194),
                      tabs: [
                        Tab(text: 'Đang xác nhận'),
                        Tab(text: 'Đã giao'),
                        Tab(text: 'Đã hủy'),
                      ],
                      labelColor: Color(0XFF4D9194),
                      unselectedLabelColor: Color.fromARGB(255, 138, 138, 138),
                      labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      unselectedLabelStyle: TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: TabBarView(
                      children: [
                        Donhangxacnhan(),
                        Donhangnhan(),
                        DonhangHuy(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
