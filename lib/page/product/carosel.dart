import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageCarousel extends StatelessWidget {
  final List<String> imgList = [
    'assets/carosel/hinh1.png',
    'assets/carosel/hinh2.png',
    'assets/carosel/hinh3.png',
  ];
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
           enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 1000),
        viewportFraction: 0.45,
      ),
      items: imgList.map((item) {
        bool isCurrent = imgList.indexOf(item) == 1; 
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              if (!isCurrent)  
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset:const Offset(0, 3),  
                ),
            ],
            border: Border.all(
              color: isCurrent ? Colors.transparent : Colors.green,
              width: 3,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(
              item,
              fit: BoxFit.cover,
              width: 600,
            ),
          ),
        );
      }).toList(),
    );
  }
}