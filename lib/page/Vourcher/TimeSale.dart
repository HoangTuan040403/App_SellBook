import 'package:flutter/material.dart';
import 'dart:async';

class FlashSaleBanner extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _FlashSaleBannerState createState() => _FlashSaleBannerState();
}

class _FlashSaleBannerState extends State<FlashSaleBanner> {
  late Timer _timer;
  int hours = 24;
  int minutes = 0;
  int seconds = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          seconds = 59;
          if (minutes > 0) {
            minutes--;
          } else {
            minutes = 59;
            if (hours > 0) {
              hours--;
            } else {
              _timer.cancel();
            }
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(25),
        
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8.0,right: 8.0),
            child: Text(
              'FLASH  SALE:',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 0, 0),
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),         
          ),
          const SizedBox(width: 8),
          _buildTimeBox(hours),
          const SizedBox(width: 4),
          const Text(':', style: TextStyle(fontSize: 18, color: Colors.black)),
          const SizedBox(width: 4),
          _buildTimeBox(minutes),
          const SizedBox(width: 4),
          const Text(':', style: TextStyle(fontSize: 18, color: Colors.black)),
          const SizedBox(width: 4),
          _buildTimeBox(seconds),
          const SizedBox(width: 4),
        ],
      ),
    );
  }

  Widget _buildTimeBox(int time) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        time.toString().padLeft(2, '0'),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
