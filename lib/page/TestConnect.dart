import 'package:doan_cuahangbansach/page/OrderDetail/mainOrder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _ThongBaoState();
}

class _ThongBaoState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thông báo',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 32,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF4D9194),
        actions: const [
          Padding(padding: EdgeInsets.only(right: 16.0),
          child: Icon(Icons.message_sharp, color: Colors.white,),)
        ],
      ),
      body: Container(
        color: const Color(0xFFE7E7E7),
        child: Column(
          children: [
            NotificationSection(),
            Expanded(child: OrderUpdates()),
          ],
        ),
        //
      ),
    );
  }
}

class NotificationSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NotificationTile(
          icon: Icons.local_offer,
          iconColor: Colors.orange,
          title: 'Khuyến mãi',
          subtitle: 'Các mã khuyến mãi hấp dẫn đang chờ bạn!',
        ),
        NotificationTile(
          icon: Icons.access_time,
          iconColor: const Color.fromARGB(255, 233, 212, 15),
          title: 'Khung giờ vàng',
          subtitle: 'Các sản phẩm ưu đãi đang chờ bạn!!!',
        ),
        NotificationTile(
          icon: Icons.card_giftcard,
          iconColor: Colors.lightGreen,
          title: 'Phần thưởng hấp dẫn',
          subtitle: 'Tham gia sự kiện nhận quà liền tay!!!',
        ),
        const SizedBox(
          height: 6,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 16,
            ),
            Text(
              'Cập nhật đơn hàng',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        )
      ],
    );
  }
}

class NotificationTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  NotificationTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade400)),
      ),
      child: ListTile(       
        leading: CircleAvatar(
          backgroundColor: iconColor.withOpacity(0.2),
          child: Icon(icon, color: iconColor),
          
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 1, 20, 48),
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
        onTap: () {},
      ),
    );
  }
}

class OrderUpdates extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        OrderUpdateTile(),
        OrderUpdateTile(),
      ],
    );
  }
}

 
class OrderUpdateTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const MainOrder(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0); // Slide từ phải qua trái
              const end = Offset.zero;
              const curve = Curves.easeInCubic;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
         //transitionDuration: const Duration(seconds: 1),
            reverseTransitionDuration: const Duration(seconds: 1),
          ),
        );
      },
      child: Card(
        color: const Color.fromARGB(255, 176, 176, 180),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: ListTile(
          leading: Image.network(
              'https://salt.tikicdn.com/ts/product/3b/91/f4/4f4e795d7be736c9e05529d4ac6ff728.jpg'),
          title: const Text('Giao hàng thành công',
              style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: const Text(
              'Sách của bạn đã được giao thành công\nVui lòng xác nhận đơn hàng và đánh giá',
              style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}