import 'package:doan_cuahangbansach/page/Customer/CusInfo.dart';
import 'package:doan_cuahangbansach/page/Home/home_view.dart';
import 'package:doan_cuahangbansach/page/Page/favourite.dart';
import 'package:doan_cuahangbansach/page/cart/cart.dart';
import 'package:doan_cuahangbansach/page/product/ThongBao.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({Key? key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  int _selectedIndex = 1;
  final double _selectedItemSize = 25.0;

  static const List<Widget> _widgetOptions = <Widget>[
    ThongBao(),
    HomeView(),
    CusInfo(),
    Favourite(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Stack(
        children: [
          IndexedStack(
            index: _selectedIndex,
            children: _widgetOptions,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _navBar(),
          ),
        ],
      ),
    );
  }

  Widget _navBar() {
    return Container(
      height: 65,
      margin: const EdgeInsets.only(
        right: 24,
        left: 24,
        bottom: 24,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 20,
            spreadRadius: 10,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Iconsax.notification, 0),
          _buildNavItem(Iconsax.home4, 1),
          _buildNavItem(Iconsax.user, 2),
          _buildNavItem(Iconsax.heart, 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        padding: EdgeInsets.all(_selectedIndex == index ? 10.0 : 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: _selectedIndex == index ? _selectedItemSize * 1.2 : _selectedItemSize,
              color: _selectedIndex == index ? Colors.blue : Colors.grey,
            ),
            if (_selectedIndex == index)
              Container(
                margin: const EdgeInsets.only(top: 4),
                height: 2,
                width: 24,
                color: Colors.blue,
              ),
          ],
        ),
      ),
    );
  }
}
