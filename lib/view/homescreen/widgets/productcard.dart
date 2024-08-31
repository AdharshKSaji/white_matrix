import 'package:flutter/material.dart';
import 'package:white_matrix/model/productmodel.dart';
import 'package:white_matrix/view/detailsscreen.dart/details.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Stack(
        children: [
          Material(elevation: 3,borderRadius: BorderRadius.circular(20),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(boxShadow:[
                BoxShadow(color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3))
              ] ,
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white),
                  
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                      child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Hero(tag: product.image,
                      child: Image.network(
                        product.image,
                        height: 140,
                        width: 145,fit: BoxFit.cover,
                      ),
                    ),
                  )),
                  SizedBox(height: 5),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      product.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "\₹${product.originalPrice}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Qty :-${product.quantity} ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          
           
           ] ),
          );
        
      
    
  }
}
