import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

void main() {
  runApp(const OrderStatusApp());
}

class OrderStatusApp extends StatelessWidget {
  const OrderStatusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const OrderStatus(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class OrderStatus extends StatelessWidget {
  const OrderStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Status Timeline'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            OrderStatusTile(
              isFirst: true,
              isLast: false,
              status: 'Thanh toán',
              isCompleted: true,
              time: '08:00 AM',
            ),
            OrderStatusTile(
              isFirst: false,
              isLast: false,
              status: 'Đóng hàng',
              isCompleted: true,
              time: '10:30 AM',
            ),
            OrderStatusTile(
              isFirst: false,
              isLast: false,
              status: 'Giao hàng',
              isCompleted: false,
              time: '01:45 PM',
            ),
            OrderStatusTile(
              isFirst: false,
              isLast: true,
              status: 'Hoàn thành',
              isCompleted: false,
              time: '03:20 PM',
            ),
          ],
        ),
      ),
    );
  }
}

class OrderStatusTile extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final String status;
  final bool isCompleted;
  final String time;

  const OrderStatusTile({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.status,
    required this.isCompleted,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      alignment: TimelineAlign.start, // Align everything to the left
      isFirst: isFirst,
      isLast: isLast,
      indicatorStyle: IndicatorStyle(
        width: 40,
        height: 40,
        indicator: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: isCompleted
                  ? [Colors.green, Colors.lightGreen]
                  : [Colors.grey, Colors.blueGrey],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              isCompleted ? Icons.check : Icons.close,
              color: Colors.white,
            ),
          ),
        ),
      ),
      beforeLineStyle: LineStyle(
        color: isCompleted ? Colors.green : Colors.grey,
        thickness: 6,
      ),
      afterLineStyle: LineStyle(
        color: isCompleted ? Colors.green : Colors.grey,
        thickness: 6,
      ),
      endChild: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: 1.0,
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    isCompleted ? Icons.done_all : Icons.timelapse,
                    color: isCompleted ? Colors.green : Colors.grey,
                    size: 30,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        status,
                        style: TextStyle(
                          fontSize: 18,
                          color: isCompleted ? Colors.black : Colors.grey,
                          fontWeight: isCompleted
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 14,
                            color: isCompleted ? Colors.black : Colors.grey,
                          ),
                          children: [
                            const TextSpan(text: 'Thời gian: '),
                            TextSpan(
                              text: time,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
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
