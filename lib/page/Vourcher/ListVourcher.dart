import 'package:doan_cuahangbansach/data/model/product.dart';
import 'package:doan_cuahangbansach/item/ItemVourcher.dart';
import 'package:doan_cuahangbansach/page/Vourcher/TimeSale.dart';
import 'package:flutter/material.dart';

class ListVourcher extends StatefulWidget {
  const ListVourcher({super.key});

  @override
  State<ListVourcher> createState() => _ListVourcherState();
}

class _ListVourcherState extends State<ListVourcher> {
  List<Product> lst = [];
  var stock = 100.0;
  var pro = 80.0;
  @override
  void initState() {
    super.initState();
   // fetchProducts();
  }
  void _onItemTapped() {
    setState(() {
      if (pro > 10) {
        pro -= 10;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4D9194),
        toolbarHeight: 80,
        title: FlashSaleBanner(),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFFE7E7E7),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  const Text(
                    'SALE LỚN 50%',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFFF9901),
                      fontSize: 35,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w900,
                      height: 0,
                    ),
                  ),
                  const SizedBox(height: 4),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: lst.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                    itemBuilder: (context, index) {
                      return itemVoucher(lst[index], stock, pro, _onItemTapped);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
