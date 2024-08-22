import 'package:doan_cuahangbansach/page/Login_Register/dangki.dart';
import 'package:doan_cuahangbansach/page/Login_Register/dangnhap.dart';
import 'package:flutter/material.dart';

class Layoutlogin extends StatefulWidget {
  const Layoutlogin({Key? key}) : super(key: key);

  @override
  State<Layoutlogin> createState() => _LayoutloginState();
}

class _LayoutloginState extends State<Layoutlogin> {
  int _selectedIndex = 0;
  final _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  static const List<Widget> _widgetOptions = <Widget>[
    dangnhapWidget(),
    DangkiWidget(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  child: BottomNavigationBar(
                    items: List.generate(_widgetOptions.length, (index) {
                      String label;
                      switch (index) {
                        case 0:
                          label = 'Đăng Nhập';
                          break;
                        case 1:
                          label = 'Đăng Ký';
                          break;
                        default:
                          label = 'Đăng nhập';
                      }
                      return BottomNavigationBarItem(
                        icon: Container(
                          decoration: BoxDecoration(
                            color: _selectedIndex == index
                                ? const Color.fromARGB(255, 41, 41, 41)
                                    .withOpacity(1)
                                : Colors.transparent,
                          ),
                        ),
                        label: label,
                      );
                    }),
                    backgroundColor: const Color(0xFFF2F2F2),
                    currentIndex: _selectedIndex,
                    selectedItemColor: const Color(0xFF4D9194),
                    selectedFontSize: 17,
                    selectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                    unselectedItemColor: const Color(0xFF98D7DB),
                    onTap: _onItemTapped,
                  ),
                ),
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  children: _widgetOptions,
                ),
              ),
            ],
          ),
        ),
      
    );
  }
}
