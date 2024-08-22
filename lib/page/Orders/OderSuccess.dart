import 'package:doan_cuahangbansach/page/Home/home_view.dart';
import 'package:doan_cuahangbansach/page/OrderDetail/mainOrder.dart';
import 'package:doan_cuahangbansach/page/conf/const.dart';
import 'package:doan_cuahangbansach/page/mainpage.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OderSuccess extends StatelessWidget {
  const OderSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        child: Stack(alignment: Alignment.center, children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(alignment: Alignment.topCenter, children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Center(
                          child: Container(
                            height: 350,
                            width: 400,
                            // color: backgroundColor,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 10,
                                      offset: Offset(0, 2))
                                ]),

                            child: const Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Bạn đã đặt hàng thành công !',
                                  style: greentitle,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                    child: Text(
                                  'Đơn hàng sẽ được xử lí và gửi đi trong thời gian sớm nhất.',
                                ))
                              ],
                            )),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ]),
              //button
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                           Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainOrder()));                 
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'Xem lại đơn hàng',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4D9096)),
                          ),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Mainpage()));
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'Tiếp tục mua hàng',
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
          const Positioned(
            top: 100,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: textColor,
              child: Icon(Icons.check, color: backgroundColor, size: 30),
            ),
          ),
        ]),
      ),
    );
  }
}
