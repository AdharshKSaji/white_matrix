import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:white_matrix/model/productmodel.dart';


class ProductController extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<ProductModel> _products = []; 
  List<ProductModel> _filteredProducts = []; 

  List<ProductModel> get filteredProducts => _filteredProducts;


  ProductController() {
    fetchProductsFromFirestore();
  }

  // Fetch products from Firestore
  Future<void> fetchProductsFromFirestore() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('products').get();
      _products = querySnapshot.docs.map((doc) {
        return ProductModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
      _filteredProducts = _products;
      notifyListeners();
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  
  void searchProducts(String query) {
    if (query.isEmpty) {
      _filteredProducts = _products; 
    } else {
      _filteredProducts = _products
          .where((product) =>
              product.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners(); 
  }

  Future<void> addProduct(ProductModel product) async {
    try {
      await _firestore.collection('products').add(product.toMap());
      _products.add(product);
      _filteredProducts = _products;
      notifyListeners();
    } catch (e) {
      print('Error adding product: $e');
    }
  }

  Future<void> removeProduct(String productId) async {
    try {
      await _firestore.collection('products').doc(productId).delete();
      _products.removeWhere((product) => product.title == productId);
      _filteredProducts = _products; 
      notifyListeners();
    } catch (e) {
      print('Error removing product: $e');
    }
  }

  Future<void> updateProductQuantity(ProductModel product, int quantity) async {
    try {
      await _firestore
          .collection('products')
          .doc(product.title) 
          .update({'quantity': quantity});
      int index = _products.indexOf(product);
      if (index != -1) {
        _products[index].quantity = quantity;
        _filteredProducts = _products; 
        notifyListeners();
      }
    } catch (e) {
      print('Error updating product quantity: $e');
    }
  }
}
