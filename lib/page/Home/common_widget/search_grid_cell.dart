import 'package:flutter/material.dart';

class SearchGridCell extends StatelessWidget {
  final Map sObj;
  final int index;
  const SearchGridCell({super.key, required this.sObj, required this.index});
  static List<Color> get searchBGColor => const [
        Color(0xffB7143C),
        Color(0xffE6A500),
         Color(0xffEF4C45),
        Color(0xffF46217),
         Color(0xff09ADE2),
        Color(0xffD36A43),
      ];
      
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          color: searchBGColor[index % searchBGColor.length],
          borderRadius: BorderRadius.circular(15)),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 4),
      child: Column(
        children: [
          Text(
            sObj["name"].toString(),
            maxLines: 1,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 15,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              sObj["img"].toString(),
              width: media.width * 0.23,
              height: media.width * 0.23 * 1.6,
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }
}
