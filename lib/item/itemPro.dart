import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:doan_cuahangbansach/data/model/product.dart';


String normalizeBase64(String base64String) {
   while (base64String.length % 4 != 0) {
    base64String += '=';
  }
  return base64String;
}

Widget itemGridView(Product items) {
  final formatter = NumberFormat('#,##0', 'en_US');

  // chuyển base64
  String  chuoiBase64 = normalizeBase64(items.img ?? '');
  Uint8List imageBytes = base64Decode(chuoiBase64);

  return Container(
    margin: const EdgeInsets.all(2),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      border: Border.all(color: const Color(0xFF4D9194), width: 2),
    ),
    child: Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Image.memory(
                imageBytes,
                height: 140,
                width: 90,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.image),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Row(
                children: [
                  Text(
                    items.name ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    selectionColor: const Color.fromARGB(255, 0, 0, 1),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Row(
                children: [
                  Text(
                    'Gia da giam',  
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 172, 171, 171),
                    ),
                    selectionColor: Color.fromARGB(255, 0, 0, 1),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Row(
                children: [
                  Text(
                    'Danh Gia',  
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 6,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 225, 0)),
                    selectionColor: Color.fromARGB(255, 0, 0, 1),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Row(
                children: [
                  Text(
                    formatter.format(items.price ?? 0), // Định dạng số với NumberFormat
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 0, 0)),
                    selectionColor: const Color.fromARGB(255, 0, 0, 1),
                  ),
                ],
              ),
            ),
          ],
        ),
        // Thẻ Card hiển thị % giảm giá
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF4D9194),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(7.0),
                bottomLeft: Radius.circular(10.0),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
            child: const Text(
              '10%',
              style: TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
