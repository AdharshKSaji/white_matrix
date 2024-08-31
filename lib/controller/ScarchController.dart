

// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:white_matrix/controller/cartcontroller.dart';
// import 'package:white_matrix/model/fetchmodel.dart';
// import 'package:white_matrix/model/productmodel.dart';
// class ScratchController extends ChangeNotifier {
//   ProductModel? selectedProduct;

//   Future<void> fetchRandomProduct() async {
//     final products = await fetchProducts(); 
//     if (products.isNotEmpty) {
//       selectedProduct = products[Random().nextInt(products.length)];
//       notifyListeners();
//     } else {
//       throw Exception('No products available');
//     }
//   }
// void addProductToCart(BuildContext context) {
//   if (selectedProduct != null) {
//     final offerProduct = ProductModel(
//       originalPrice:0,
//       title: selectedProduct!.title,
//       description: selectedProduct!.description,
//       image: selectedProduct!.image,
//       review: selectedProduct!.review,
//       seller: selectedProduct!.seller,
//       price: 0.0, 
//       rate: selectedProduct!.rate,
//       quantity: 1, 
//     );
//     context.read<CartController>().addToCart(offerProduct, qty: 1);
//     notifyListeners();
//   }
// }
// }
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:white_matrix/controller/cartcontroller.dart';
import 'package:white_matrix/model/fetchmodel.dart';
import 'package:white_matrix/model/productmodel.dart';

class ScratchController extends ChangeNotifier {
  ProductModel? selectedProduct;

  Future<void> fetchRandomProduct() async {
    final products = await fetchProducts();
    if (products.isNotEmpty) {
      selectedProduct = products[Random().nextInt(products.length)];
      notifyListeners();
    } else {
      throw Exception('No products available');
    }
  }

  void addProductToCart(BuildContext context) {
    if (selectedProduct != null) {
      final offerProduct = ProductModel(
        originalPrice: 0, // Assuming offer price is zero
        title: selectedProduct!.title,
        description: selectedProduct!.description,
        image: selectedProduct!.image,
        review: selectedProduct!.review,
        seller: selectedProduct!.seller,
        rate: selectedProduct!.rate,
        quantity: 0, // Set quantity to 1
        price: 0.0, // Assuming offer price is zero
      );
      context.read<CartController>().addToCart(offerProduct, qty: 1);
      notifyListeners();
    }
  }
}
