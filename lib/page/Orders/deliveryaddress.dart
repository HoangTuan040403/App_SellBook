import 'package:flutter/material.dart';

class address extends StatefulWidget {
  const address({super.key});

  @override
  State<address> createState() => _addressState();
}

class _addressState extends State<address> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Địa chỉ giao hàng'),
      ),
      body: Container(        
        color: const Color(0xFFE7E7E7),

        child: ListView(
          children: [
            InfoUser(),
            InfoUser(),
            InfoUser(),
            InfoUser(),
            TextButton(
                onPressed: () {},
                child: const Text('Thêm địa chỉ nhận hàng',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.orange)))
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget InfoUser() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black, blurRadius: 10, offset: Offset(0, 2))
            ]),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Địa chỉ nhận hàng',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text('Trần Hoài An | (+84) 9xx xxx xxx'),
                Text('828 Sư Vạn Hạnh'),
                Divider(),
                Row(children: [
                  Radio(value: true, groupValue: null, onChanged: null),
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
