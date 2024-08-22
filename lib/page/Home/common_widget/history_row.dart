import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HistoryRow extends StatelessWidget {
  final Map sObj;
  const HistoryRow({super.key, required this.sObj});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(sObj["img"].toString(),
                width: media.width * 0.25,
                height: media.width * 0.25 * 1.6,
                fit: BoxFit.cover),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              const SizedBox(
            height: 8,
          ),
                Text(
                sObj["name"].toString(),
                maxLines: 3,
                textAlign: TextAlign.left,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                sObj["author"].toString(),
                maxLines: 1,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: const Color(0xff212121).withOpacity(0.4),
                  fontSize: 13,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              IgnorePointer(
                ignoring: true,
                child: RatingBar.builder(
                  initialRating:
                      double.tryParse(sObj["rating"].toString()) ?? 1,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 15,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Color(0xFF4D9194),
                  ),
                  onRatingUpdate: (rating) {},
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                sObj["description"].toString(),
                maxLines: 2,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: const Color(0xff212121).withOpacity(0.3),
                  fontSize: 11,
                ),
              ),
              const SizedBox(
                height: 8,
              ),

              Row(children: [
                  Expanded(child: Container(
                    height: 30.0,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors:  [  Color(0xff5ABD8C), Color(0xff00FF81), ]
                            ), 
                            borderRadius: BorderRadius.circular(10), 
                            boxShadow:  const [
                               BoxShadow(color: Color(0xFF4D9194), blurRadius: 2, offset: Offset(0, 2),)
                            ] ),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent),
                      child: const Text('Add to cart',  style: TextStyle(fontSize: 12),),
                    ),
                  ),),

          const SizedBox(
                    width: 8,
                  ),
                   Expanded(child: Container(
                    height: 30.0,
                    decoration: BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: const  [
                               BoxShadow(color: Colors.black12, blurRadius: 2, offset:  Offset(0, 2),)
                            ] ),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.black,
                          shadowColor: Colors.transparent),
                      child:  const Text('Add to wishlist', style: TextStyle( color: Colors.black,fontSize: 12) ,),
                    ),
                  ))
              ],)
            ],
          ))
        ],
      ),
    );
  }
}
