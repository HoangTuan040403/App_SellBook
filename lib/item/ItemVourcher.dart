import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
 import 'package:doan_cuahangbansach/data/model/product.dart';
String normalizeBase64(String base64String) {
   while (base64String.length % 4 != 0) {
    base64String += '=';
  }
  return base64String;
}
 Widget itemVoucher(Product item, double stock, double pro, VoidCallback onTap) {
    String  chuoiBase64 = normalizeBase64(item.img ?? '');
  Uint8List imageBytes = base64Decode(chuoiBase64);
   return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  width: 240,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 223, 221, 221),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(255, 205, 205, 205),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.memory(
                            imageBytes,
                            height: 130,
                            width: 130,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                        soLuongBan(stock, pro) // truyền mã sản phẩm vào
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xff4D9194),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Column(
                      children: [
                        Text(
                          item.name ?? '',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        InkWell(
                          onTap: onTap,
                          child:const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 14 ),
                                child: Text(
                                 '100.000 VNĐ',
                                 textAlign: TextAlign.center,
                                 style: TextStyle(
                                   fontSize: 11,
                                   fontWeight: FontWeight.bold,
                                   color: Color.fromARGB(255, 196, 194, 194),
                                   decoration: TextDecoration.lineThrough,
                                 ),
                                                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  // formatter.format(item.price ?? 0),
                                  '200 000 vnd',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 255, 255, 0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Discount label
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xffFF0000),
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              padding: const EdgeInsets.all(5),
              child: const Text(
                '10%',
                style: TextStyle(
                  fontSize: 13,
                  color: Color.fromARGB(255, 255, 251, 0),
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
// truyền mã sản phẩm vào
 Widget soLuongBan(double stock, double progress) {
  return Padding(
    padding: const EdgeInsets.only(left: 8.0),
    child: RotatedBox(
      quarterTurns: 2,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            height: stock,
            width: 13,
          ),
          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 255, 0, 0),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.0),
                topLeft: Radius.circular(10.0),
              ),
            ),
            height: progress,
            width: 13,
          ),
        ],
      ),
    ),
  );
}
