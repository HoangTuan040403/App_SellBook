import 'package:doan_cuahangbansach/dbhelper/mongodb.dart';
import 'package:doan_cuahangbansach/page/Home/home_view.dart';
import 'package:doan_cuahangbansach/page/Login_Register/dangnhap.dart';
import 'package:doan_cuahangbansach/page/Login_Register/layoutLogin.dart';
import 'package:doan_cuahangbansach/page/cart/cartcounter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartItemCountProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget { 
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {  
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      title: 'ứng dụng bán sách',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const Layoutlogin()
    );
  }
}
