import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:white_matrix/controller/favcontroller.dart';
import 'package:white_matrix/controller/cartcontroller.dart';
import 'package:white_matrix/model/productmodel.dart';

import 'package:white_matrix/view/cartscreen/CartScreen.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteController>(context);
    final cartProvider = Provider.of<Cartcontroller>(context);

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        favoriteProvider.isExist(product)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                        size: 22,
                      ),
                      onPressed: () {
                        favoriteProvider.toggleFavorite(product);
                        final snackBar = SnackBar(
                          content: Text(favoriteProvider.isExist(product)
                              ? '${product.title} added to favorites!'
                              : '${product.title} removed from favorites!'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                    ),
                    const Spacer(),
                    // Uncomment if you want to display a cart icon here
                    // IconButton(
                    //   icon: const Icon(Icons.shopping_cart, color: Colors.black),
                    //   onPressed: () {
                    //     cartProvider.addCart(product);
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(builder: (context) => CartScreen()),
                    //     );
                    //   },
                    // ),
                  ],
                ),
                const SizedBox(height: 16),
                Center(
                  child: Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        product.image,
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  product.title,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "₹${product.price.toString()}",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  product.description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                Divider(),
                Text(
                  "Seller:",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                Text(
                  product.seller,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          cartProvider.Addcart(product);  // Add product to cart
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CartScreen(),
                            ),
                          );
                        },
                        child: const Text('Buy Now'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
