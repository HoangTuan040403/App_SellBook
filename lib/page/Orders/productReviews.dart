// Đảm bảo rằng file này tồn tại và các biến được khởi tạo đúng cách
import 'dart:ui';
 

import 'package:doan_cuahangbansach/page/conf/const.dart';
import 'package:flutter/material.dart';

class ProductReviews extends StatefulWidget {
  const ProductReviews({super.key});

  @override
  State<ProductReviews> createState() => _ProductReviewsState();
}

class _ProductReviewsState extends State<ProductReviews> {
  // Khởi tạo biến nếu cần
  final Color = backgroundColor;  
  final TextStyle titleStyle =
      TextStyle(color: Colors.white, fontSize: 24);  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đánh giá sản phẩm'),
      ),
      body: ListView(
        children: [
          Column(
           children: [
             Container(
               width: double.infinity, // Sử dụng toàn bộ chiều rộng màn hình
               color: backgroundColor,
               child: Padding(
                 padding: const EdgeInsets.all(16.0),
                 child: Text(
                   'Thông tin sản phẩm',
                   style:
                       titleStyle.copyWith(color: Colors.white, fontSize: 26),
                 ),
               ),
             ),
             ProductOder(),
             Padding(
               padding: const EdgeInsets.all(16.0),
               child: Row(
                 children: [
                   const Text('Chất lượng sản phẩm'),
                   Spacer(), // Tạo khoảng cách giữa Text và các sao
                   Row(
                     children: List.generate(
                       5,
                       (index) => const Icon(
                         Icons.star,
                         size: 24,
                         color: Colors.orange,
                       ),
                     ),
                   ),
                 ],
               ),
             ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Container(
                 height: 300,
                 decoration: const BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.all(Radius.circular(10)),
                   boxShadow: [BoxShadow(blurRadius: 3, offset: Offset(2, 0))],
                 ),
                 child: const Padding(
                   padding: EdgeInsets.all(16.0),
                      
                   // đánh giá
                   child: SingleChildScrollView(
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text('Để lại đánh giá'),
                         TextField(
                           keyboardType: TextInputType.multiline,
                           maxLines: 10,
                           decoration: InputDecoration(
                             border:
                                 InputBorder.none, // Xóa viền của TextField
                           ),
                         )
                       ],
                     ),
                   ),
                 ),
               ),
             ),
             const SizedBox(
               height: 10,
             ),
             ElevatedButton(
               onPressed: () {},
               child: Text('Đánh giá'),
               style:
                   ElevatedButton.styleFrom(backgroundColor: backgroundColor),
             ),
           ],
                      ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget ProductOder() {
    return Padding(
      padding: const EdgeInsets.only(top: 26.0, bottom: 10, left: 5, right: 5),
      child: Container(
        width: double.infinity, // Sử dụng toàn bộ chiều rộng màn hình
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding:
              EdgeInsets.all(10), // Giảm padding để tăng chiều rộng khả dụng
          child: Row(
            children: [
              Image.network(
                'https://th.bing.com/th/id/OIP.8Bvucb7uRIbVBIBQfXOJmAAAAA?rs=1&pid=ImgDetMain',
                height: 140,
                width: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error),
              ),
              // Thông tin sản phẩm
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tấm lòng cao cả',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '163.170',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'số lượng : 1',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
