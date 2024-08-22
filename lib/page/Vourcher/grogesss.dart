import 'package:flutter/material.dart';

// var stock = 100.0;
// var pro = 80.0;

// void _onItemTapped() {
//   setState(() {
//     if (pro > 10) {
//       pro -= 10;
//     }
//   });
// }

@override
Widget soLuongBan( var stockPro, var pro) {
  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 10,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(25.7),
          ),
          color: Colors.grey,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  //    Image.network(
                  //   order.imageUrl!,
                  //   width: 50,
                  //   height: 50,
                  // ),
                  RotatedBox(
                    quarterTurns: 2,
                    child: Stack(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                              topLeft: Radius.circular(10.0),
                            ),
                          ),
                          height: stockPro,
                          width: 4,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 0, 183, 255),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              topLeft: Radius.circular(10.0),
                            ),
                          ),
                          height: pro,
                          width: 4,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: ElevatedButton(
                    onPressed: () {
                      //      _onItemTapped();
                    },
                    child: const Text('mua hàng')),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
