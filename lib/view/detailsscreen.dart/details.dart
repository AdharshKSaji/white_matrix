import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:white_matrix/controller/favcontroller.dart';
import 'package:white_matrix/controller/cartcontroller.dart';
import 'package:white_matrix/model/productmodel.dart';
import 'package:white_matrix/view/cartscreen/CartScreen.dart';
import 'package:white_matrix/view/checkoutscreen/checkoutscreen.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteController>(context);
    final cartProvider = Provider.of<CartController>(context); 

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
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
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
                  ],
                ),
                const SizedBox(height: 16),
                Center(
                  child: Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Hero(tag: product.image,
                        child: Image.network(
                          product.image,
                          height: 250,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
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
                  "₹${product.originalPrice.toString()}",
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
                const Divider(),
                const Text(
                  "Seller:",
                  style: TextStyle(
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
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    
                      ElevatedButton(
  onPressed: () {
    cartProvider.addToCart(product, qty: 1); 
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartScreen(),
      ),
    );
  },
  style: ElevatedButton.styleFrom(
    foregroundColor: Colors.white, 
    backgroundColor: Colors.black, 
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), 
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12), 
    ),
    textStyle: TextStyle(
      fontSize: 16, 
      fontWeight: FontWeight.w600, 
    ),
    elevation: 5, 
  ),
  child: const Text('Add To Cart'),
)

                     ,  ElevatedButton(
  onPressed: () {
    cartProvider.addToCart(product, qty: 1); 
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutScreen(),
      ),
    );
  },
  style: ElevatedButton.styleFrom(
    foregroundColor: Colors.white, 
    backgroundColor: Colors.black, 
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), 
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16), 
    ),
    textStyle: TextStyle(
      fontSize: 18, 
      fontWeight: FontWeight.bold,
    ),
  ),
  child: const Text('Buy Now'),
)      
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
