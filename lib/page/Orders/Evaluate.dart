import 'package:flutter/material.dart';

class Evaluate extends StatefulWidget {
  const Evaluate({super.key});

  @override
  State<Evaluate> createState() => _EvaluateState();
}

class _EvaluateState extends State<Evaluate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đánh giá'),
      ),
      body: Container(
          color: const Color(0xFFE7E7E7),
          child: ListView(children: [Product(), Product(), Product()])),
    );
  }
}

Widget Product() {
  return Card(
    margin: const EdgeInsets.all(10.0), // Add margin around the card
    child: Padding(
      padding: const EdgeInsets.all(16.0), // Add padding within the card
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Image container
          Container(
            width: 80.0, // Set a fixed width for the image
            height: 120.0, // Set a fixed height for the image
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: AssetImage('image/imgHome/theloai.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          // Product information
          Expanded(
            // Use Expanded widget to fill remaining space
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tấm lòng cao cả',
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                    height: 8.0), // Add spacing between title and description
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.orange, width: 1),
                            borderRadius: BorderRadius.circular(5)),
                        child: const Padding(
                            padding: EdgeInsets.all(3),
                            child: Text('Đổi trả 15 ngày'))),
                  ],
                ),
                const SizedBox(height: 4.0),
                Row(
                  children: [
                    const Text(
                      '163.170đ',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                    height: 4.0), // Add spacing between price and quantity
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Số lượng: 1'),
                    ElevatedButton(onPressed: null, child: Text('Đánh giá'))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
