import 'package:flutter/material.dart';

class MyPaymentMethod extends StatelessWidget {
  const MyPaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh toán'),
      ),
      body: const Center(
        child: Text('Nội dung của Thanh toán'),
      ),
    );
  }
}