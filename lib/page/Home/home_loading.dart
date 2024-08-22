// ignore: file_names
import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _HomewidgetState();
}

class _HomewidgetState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Text('Đang Tải'),
        ),
      ),
    );
  }
}
