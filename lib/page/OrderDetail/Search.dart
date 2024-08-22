// ignore: file_names
import 'package:flutter/material.dart';

class SearchOrder extends StatefulWidget {
  const SearchOrder({super.key});

  @override
  State<SearchOrder> createState() => _SearchOrderState();
}

class _SearchOrderState extends State<SearchOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon:const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: const Color(0xFF4D9194),
        title: const Text(
          'Tìm kiếm đơn hàng',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFFE7E7E7),
        child: const Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 16),
                TextField(
                  //  controller: _searchController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.7)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF4D9194),
                      ),
                    ),
                    hintText: "Tìm kiếm...",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
