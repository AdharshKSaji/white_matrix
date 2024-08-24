import 'package:flutter/material.dart';
import 'package:white_matrix/model/cartmodel.dart';
import 'package:white_matrix/model/productmodel.dart';

class CheckoutController extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  
  List<CartModel> _cartItems = [];
  
  // Getters for the controllers' text
  String get name => nameController.text;
  String get address => addressController.text;
  String get phoneNumber => phoneNumberController.text;
  String get pinCode => pinCodeController.text;
  
  List<CartModel> get cartItems => _cartItems;
  
  // Methods to update the controllers' text
  void updateName(String name) {
    nameController.text = name;
    notifyListeners();
  }

  void updateAddress(String address) {
    addressController.text = address;
    notifyListeners();
  }

  void updatePhoneNumber(String phoneNumber) {
    phoneNumberController.text = phoneNumber;
    notifyListeners();
  }

  void updatePinCode(String pinCode) {
    pinCodeController.text = pinCode;
    notifyListeners();
  }

  // Methods for cart operations
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

  // Dispose controllers to prevent memory leaks
  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    phoneNumberController.dispose();
    pinCodeController.dispose();
    super.dispose();
  }
}
