import 'dart:convert';
import 'dart:typed_data';
import 'package:doan_cuahangbansach/data/model/category.dart';
import 'package:flutter/material.dart';

String normalizeBase64(String base64String) {
  while (base64String.length % 4 != 0) {
    base64String += '=';
  }
  return base64String;
}

// ignore: non_constant_identifier_names
Widget genres_cell(CateGorys cate, BuildContext context, Color bgcolor) {
  // Chuẩn hóa base64
  String chuoiBase64 = normalizeBase64(cate.img ?? '');
  Uint8List imageBytes = base64Decode(chuoiBase64);
  var media = MediaQuery.of(context).size;
  return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: bgcolor, borderRadius: BorderRadius.circular(15)),
      // color: Colors.red,
      width: media.width * 0.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.memory(
            imageBytes,
            width: media.width * 0.7,
            height: media.width * 0.35,
            fit: BoxFit.fitWidth,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            cate.name!,
            maxLines: 3,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),
          ),
        ],
      ));
}
