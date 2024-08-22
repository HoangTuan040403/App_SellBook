import 'dart:convert';
import 'dart:typed_data';
import 'package:doan_cuahangbansach/data/model/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

 String normalizeBase64(String base64String) {
   while (base64String.length % 4 != 0) {
    base64String += '=';
  }
  return base64String;
}
  Widget BestSellerCell(Product pro,BuildContext context) {
      // chuyển base64
  String  chuoiBase64 = normalizeBase64(pro.img ?? '');
  Uint8List imageBytes = base64Decode(chuoiBase64);
    var media = MediaQuery.of(context).size;
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        // color: Colors.red,
        width: media.width * 0.32,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black38,
                        offset: Offset(0, 2),
                        blurRadius: 5)
                  ]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
             child: Image.memory(
                imageBytes,
                  width: media.width * 0.32,
                  height: media.width * 0.50,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
             pro.name!,
              maxLines: 3,
              textAlign: TextAlign.left,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              pro.des!,
              maxLines: 1,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: const Color(0xff212121).withOpacity(0.4),
                fontSize: 11,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            IgnorePointer(
              ignoring: true,
              child: RatingBar.builder(
                initialRating: 2,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 15,
                itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Color(0xFF4D9194),
                ),
                onRatingUpdate: (rating) {},
              ),
            )
          ],
        ));
  }
