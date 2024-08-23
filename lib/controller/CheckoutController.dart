import 'package:flutter/material.dart';
import 'package:white_matrix/model/cartmodel.dart';
import 'package:white_matrix/model/productmodel.dart'; 
class CheckoutController extends ChangeNotifier {
  String _name = '';
  String _address = '';
  String _phoneNumber = '';
  String _pinCode = '';
  List<CartModel> _cartItems = [];
  String get name => _name;
  String get address => _address;
  String get phoneNumber => _phoneNumber;
  String get pinCode => _pinCode;
  List<CartModel> get cartItems => _cartItems;


  void updateName(String name) {
    _name = name;
    notifyListeners();
  }

  void updateAddress(String address) {
    _address = address;
    notifyListeners();
  }

  void updatePhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
    notifyListeners();
  }

  void updatePinCode(String pinCode) {
    _pinCode = pinCode;
    notifyListeners();
  }
  void addItemToCart(CartModel item) {
    _cartItems.add(item);
    notifyListeners();
  }
  void removeItemFromCart(ProductModel product) {
    _cartItems.removeWhere((item) => item.product == product);
    notifyListeners();
  }
  double get totalPrice {
    double total = 0.0;
    for (var item in _cartItems) {
      total += item.product.price * item.quantity;
    }
    return total;
  }
}
