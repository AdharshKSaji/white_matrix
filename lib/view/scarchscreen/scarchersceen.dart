import 'package:flutter/material.dart';
import 'package:scratcher/scratcher.dart';
import 'package:provider/provider.dart'; // Adjust import based on your project structure
import 'package:white_matrix/controller/cartcontroller.dart'; // Adjust import based on your project structure
import 'package:white_matrix/model/productmodel.dart';
import 'package:white_matrix/view/cartscreen/CartScreen.dart'; // Import the CartScreen

class ScratchScreen extends StatelessWidget {
  final ProductModel product;

  const ScratchScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Special Offer'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: 300.0,
            child: Scratcher(
              brushSize: 50,
              threshold: 50,
              color: Colors.blueGrey,
              onChange: (value) {
                print("Scratch progress: $value%");
              },
              onThreshold: () {
                // Add the product to the cart
                Provider.of<CartController>(context, listen: false).addToCart(product, qty: 1);
                // Navigate to the CartScreen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => CartScreen()),
                );
              },
              child: Container(
                alignment: Alignment.center,
                color: Colors.white,
                child: const Text(
                  "RS 0 Offer!\nScratch to Reveal",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
