import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:white_matrix/model/productmodel.dart';
import 'package:white_matrix/model/cartmodel.dart';

class CartController extends ChangeNotifier {
  final List<CartModel> _cartList = [];
  List<CartModel> get cart => _cartList;

  void addToCart(ProductModel product, {required int qty}) {
    // Check if the product is already in the cart
    final cartItemIndex = _cartList.indexWhere(
      (item) => item.product.title == product.title,
    );

    if (cartItemIndex != -1) {
      // If product is already in cart, we do not add more
      // Ensure the quantity remains 1
      _cartList[cartItemIndex].qty = 1;
    } else {
      // Add new product with quantity 1
      _cartList.add(CartModel(product: product, qty: 1));
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
      (total, item) => total + (item.product.originalPrice * item.qty),
    );
  }

  static CartController of(BuildContext context, {bool listen = true}) {
    return Provider.of<CartController>(context, listen: listen);
  }
}
