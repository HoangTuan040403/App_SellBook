import 'package:flutter/material.dart';

class MyRank extends StatelessWidget {
  const MyRank({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thẻ thành viên'),
      ),
      body: const Center(
        child: Text('Nội dung của Thẻ thành viên'),
      ),
    );
  }
}