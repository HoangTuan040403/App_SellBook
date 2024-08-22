import 'package:doan_cuahangbansach/data/model/giohang.dart';
import 'package:doan_cuahangbansach/page/cart/cart.dart';
import 'package:flutter/material.dart';

class CartItemCountProvider with ChangeNotifier {
  int _itemCount=0;

  int get itemCount => _itemCount;

  void setItemCount(int count) {
    _itemCount = count;
    notifyListeners();
  }

  void incrementItemCount() {
    _itemCount++;
    notifyListeners();
  }

  void decrementItemCount() {
    if (_itemCount > 0) {
      _itemCount--;
      notifyListeners();
    }
  }
 void updateItemCountDetail() {
  _itemCount += 1;
  notifyListeners();
   print(_itemCount);
}


 void updateItemCountOder() {
  _itemCount -= 1;
  notifyListeners();
   print(_itemCount);
}
  void updateItemCount(List<GioHang> cartItems) {
  _itemCount = soluongSP(cartItems);
  notifyListeners();
}

  void loadCartItems(String idCus) async {
  try {
    var cartItems = await fetchCartItems(idCus); 
    _itemCount = soluongSP(cartItems);
    notifyListeners();
    print(_itemCount);
  } catch (e) {
    print('Error loading cart items: $e');
  }
}

}
