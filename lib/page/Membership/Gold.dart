import 'package:flutter/material.dart';

// Item widget with truck and gift images
class Item extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;

  const Item({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          color: Colors.white,
          child: Row(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Gold widget with gold medal image
class Gold extends StatelessWidget {
  const Gold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Gold Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: double.infinity,
                    height: 220,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(222, 222, 222, 1),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 50, // Adjust as needed
                    bottom: 16, // Adjust as needed
                    child: Image.asset(
                      'assets/images/membership/gold-medal.png', // Change to AssetImage
                      width: 150, // Adjust width as needed
                      height: 150, // Adjust height as needed
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 30, bottom: 20),
                    child: Text(
                      "GOLD",
                      style: TextStyle(
                        fontSize: 30,
                        color: Color.fromARGB(133, 0, 0, 0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // First Item with truck image
             const Item(
              imagePath: 'assets/images/item/truck.png', // Change to AssetImage
              title: 'Miễn phí vận chuyển',
              subtitle: 'Đã có sẵn trong kho voucher',
            ),
            // Second Item with gift image
            const Item(
              imagePath: 'assets/images/item/voucher.png', // Change to AssetImage
              title: 'Ngày hội thành viên',
              subtitle: 'Ngày 10 và 20 hàng tháng nhận voucher hạng thành viên',
            ),
             const Item(
              imagePath: 'assets/images/item/truck.png', // Change to AssetImage
              title: 'Miễn phí vận chuyển',
              subtitle: 'Đã có sẵn trong kho voucher',
            ),
            // Second Item with gift image
            const Item(
              imagePath: 'assets/images/item/voucher.png', // Change to AssetImage
              title: 'Ngày hội thành viên',
              subtitle: 'Ngày 10 và 20 hàng tháng nhận voucher hạng thành viên',
            ),
             const Item(
              imagePath: 'assets/images/item/truck.png', // Change to AssetImage
              title: 'Miễn phí vận chuyển',
              subtitle: 'Đã có sẵn trong kho voucher',
            ),
            // Second Item with gift image
            const Item(
              imagePath: 'assets/images/item/voucher.png', // Change to AssetImage
              title: 'Ngày hội thành viên',
              subtitle: 'Ngày 10 và 20 hàng tháng nhận voucher hạng thành viên',
            ),
          ],
        ),
      ),
    );
  }
}
