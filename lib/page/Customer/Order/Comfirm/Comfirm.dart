import 'package:flutter/material.dart';

class Comfirm extends StatelessWidget {
  const Comfirm({super.key});

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