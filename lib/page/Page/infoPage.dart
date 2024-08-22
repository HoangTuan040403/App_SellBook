import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4D9096),
      body: Padding(
        padding: const EdgeInsets.only(top: 80),
        child: Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'KBT',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 96,
                      color: Color(0xFFC1D6CF)),
                ),
                const Text('Nhà sách trực tuyến hàng đầu!',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.black)),
                Expanded(
                  child: Center(
                    child: Image.asset(
                      'image/imgInfo/logoinfo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
