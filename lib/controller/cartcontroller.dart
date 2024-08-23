import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:white_matrix/model/productmodel.dart';
import 'package:white_matrix/model/cartmodel.dart';  

class CartController extends ChangeNotifier {
  final List<CartModel> _cartList = [];
  List<CartModel> get cart => _cartList;

  void addToCart(ProductModel product, {required int qty}) {
    final cartItem = _cartList.firstWhere(
      (item) => item.product.title == product.title,
      orElse: () => CartModel(product: product, qty: 0),
    );

    if (cartItem.qty > 0) {
      cartItem.qty++;
    } else {
      _cartList.add(CartModel(product: product));
    }
    
    notifyListeners();
  }

  void incrementQuantity(int index) {
    if (index >= 0 && index < _cartList.length) {
      _cartList[index].qty++;
      notifyListeners();
    }
  }

  void decrementQuantity(int index) {
    if (index >= 0 && index < _cartList.length) {
      if (_cartList[index].qty <= 1) {
        _cartList.removeAt(index);
      } else {
        _cartList[index].qty--;
      }
      notifyListeners();
    }
  }

  double totalPrice() {
    return _cartList.fold(
      0.0,
      (total, item) => total + (item.product.price * item.qty),
    );
  }

  static CartController of(BuildContext context, {bool listen = true}) {
    return Provider.of<CartController>(context, listen: listen);
  }
}
