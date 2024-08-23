import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:white_matrix/controller/CheckoutController.dart';
import 'package:white_matrix/view/paymentscreen/paymentscreen.dart';

class CheckoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CheckoutController>(
      create: (_) => CheckoutController(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Checkout'),
        ),
        body: Consumer<CheckoutController>(
          builder: (context, controller, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name'),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your name',
                    ),
                    onChanged: (value) {
                      controller.updateName(value);
                    },
                  ),
                  SizedBox(height: 16),
                  Text('Shipping Address'),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your shipping address',
                    ),
                    onChanged: (value) {
                      controller.updateAddress(value);
                    },
                  ),
                  SizedBox(height: 16),
                  Text('Phone Number'),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your phone number',
                    ),
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {
                      controller.updatePhoneNumber(value);
                    },
                  ),
                  SizedBox(height: 16),
                  Text('Pin Code'),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your pin code',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      controller.updatePinCode(value);
                    },
                  ),
                  SizedBox(height: 16),
                  Text('Cart Items'),
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.cartItems.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(controller.cartItems[index]),
                          trailing: IconButton(
                            icon: Icon(Icons.remove_circle),
                            onPressed: () {
                              controller.removeItemFromCart(controller.cartItems[index]);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                       Navigator.push(context, MaterialPageRoute(builder:
                       (context) => payment(),));
                      },
                      child: Text('Proceed to Payment'),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
