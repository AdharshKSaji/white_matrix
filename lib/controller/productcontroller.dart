import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:white_matrix/model/productmodel.dart';


class ProductController extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<ProductModel> _products = []; // Store all products
  List<ProductModel> _filteredProducts = []; // Store filtered products

  List<ProductModel> get filteredProducts => _filteredProducts;

  // Constructor to load products from Firestore
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

  // Method to search products by title
  void searchProducts(String query) {
    if (query.isEmpty) {
      _filteredProducts = _products; // Show all products if the query is empty
    } else {
      _filteredProducts = _products
          .where((product) =>
              product.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners(); // Notify listeners about the change
  }

  // Method to add a new product to Firestore
  Future<void> addProduct(ProductModel product) async {
    try {
      await _firestore.collection('products').add(product.toMap());
      _products.add(product);
      _filteredProducts = _products; // Reset filtered products
      notifyListeners();
    } catch (e) {
      print('Error adding product: $e');
    }
  }

  // Method to remove a product from Firestore
  Future<void> removeProduct(String productId) async {
    try {
      await _firestore.collection('products').doc(productId).delete();
      _products.removeWhere((product) => product.title == productId);
      _filteredProducts = _products; // Reset filtered products
      notifyListeners();
    } catch (e) {
      print('Error removing product: $e');
    }
  }

  // Method to update the quantity of a product in Firestore
  Future<void> updateProductQuantity(ProductModel product, int quantity) async {
    try {
      await _firestore
          .collection('products')
          .doc(product.title) // assuming title is the document ID
          .update({'quantity': quantity});
      int index = _products.indexOf(product);
      if (index != -1) {
        _products[index].quantity = quantity;
        _filteredProducts = _products; // Reset filtered products
        notifyListeners();
      }
    } catch (e) {
      print('Error updating product quantity: $e');
    }
  }
}
