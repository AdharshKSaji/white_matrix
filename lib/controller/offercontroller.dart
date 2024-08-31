import 'package:flutter/material.dart';
import 'package:white_matrix/controller/cartcontroller.dart';
import 'package:white_matrix/model/cartmodel.dart';
import 'package:white_matrix/model/productmodel.dart'; // Import your ProductModel here

class OfferController extends ChangeNotifier {
  final CartController _cartController;

  OfferController(this._cartController);

  List<CartModel> get cartItems {
    return _cartController.cart;
  }

  ProductModel? get offerProduct {
    // Replace this with your actual offer fetching logic
    // For example, fetch a random product from your database or use a static product for the offer
    return ProductModel(
      price: 0,
     review: 'good',
     seller: 'ask',
      title: 'Special Offer Product',
      description: 'This is an offer product description.',
      image: 'https://example.com/offer-product.jpg',
      originalPrice: 0.0, 
      rate: 5.0,
      quantity: 1,
    );
  }

  void addOfferProductToCart() {
    final product = offerProduct;
    if (product != null) {
      _cartController.addToCart(product, qty: 1);
      notifyListeners();
    }
  }
}
