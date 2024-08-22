import 'package:doan_cuahangbansach/page/conf/const.dart';
import 'package:flutter/material.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  bool allSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yêu thích',style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 30
        ),),
                          automaticallyImplyLeading: false,  

        backgroundColor: backgroundColor,
      ),
      body: GestureDetector(
        onTap: () {
        // Navigator.push(
        //   context,
        //   PageRouteBuilder(
        //     pageBuilder: (context, animation, secondaryAnimation) =>
        //         const DetailProduct(),
        //     transitionsBuilder:
        //         (context, animation, secondaryAnimation, child) {
        //       const begin = Offset(-1.0, 0.0);  
        //       const end = Offset.zero;
        //       const curve = Curves.easeInCubic;
        //       var tween =
        //           Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        //       return SlideTransition(
        //         position: animation.drive(tween),
        //         child: child,
        //       );
        //     },
        //     //  transitionDuration: Duration(seconds: 1),
        //     reverseTransitionDuration: Duration(seconds: 1),
        //   ),
        // );
      },
        child: Container(
                  color: const Color(0xFFE7E7E7),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Radio<bool>(
                        value: true,
                        groupValue: allSelected,
                        onChanged: (bool? value) {
                          setState(() {
                            allSelected = value ?? false;
                          });
                        },
                      ),
                      const Text('Tất cả'),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      // Handle delete action
                    },
                    child: const Text('Xoá'),
                  ),
                ],
              ),
              Product(),
              Product(),
            ],
          ),
        ),
      ),
    );
  }
}

class Product extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Radio<bool>(
                        value: false,
                        groupValue: null,
                        onChanged: null,
                      ),
                    ),
                    Image.network(
                      'https://th.bing.com/th/id/OIP.oEBT02CI_Tp5TWupJzvcXAHaLH?rs=1&pid=ImgDetMain',
                      height: 100,
                      width: 63,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 12),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tấm lòng cao cả',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '163.170',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 80),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Bỏ thích '),
                            Icon(Icons.heart_broken_rounded)
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
