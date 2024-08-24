import 'package:flutter/material.dart';
import 'package:white_matrix/constants/colorconstants.dart/colorconstants.dart';
import 'package:white_matrix/controller/cartcontroller.dart';
import 'package:white_matrix/view/cartscreen/checkoutbox.dart';

class CartScreen extends StatefulWidget {
  CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = CartController.of(context);
    final finalList = provider.cart;
    Widget productQuantity(IconData icon, int index) {
      return GestureDetector(
        onTap: () {
          setState(() {
            if (icon == Icons.add) {
              provider.incrementQuantity(index);
            } else {
              provider.decrementQuantity(index);
            }
          });
        },
        child: Icon(
          icon,
          color: ColorConstants.primaryBlack,
        ),
      );
    }

    return Scaffold(
      bottomSheet: Checkoutbox(),
      appBar: AppBar(leading:  IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },),
        title: Text(
          " Cart",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorConstants.primaryBlack,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: finalList.length,
          itemBuilder: (context, index) {
            final cartItem = finalList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                shadowColor: Colors.grey.shade200,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Container(
                        height: 100,
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(cartItem.product.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cartItem.product.title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "\₹${cartItem.product.price.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: ColorConstants.primaryGreen,
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                productQuantity(Icons.remove, index),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                  child: Text(
                                    "${cartItem.qty}", 
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                productQuantity(Icons.add, index),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                provider.cart.removeAt(index);  
                      
                              });
                            },
                            icon: Icon(
                              Icons.delete_outline,
                              color: Colors.redAccent,
                              size: 28,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
