import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Product {
  final String id;
  final String name;
  final double price;

  Product({required this.id, required this.name, required this.price});
}

class CheckoutController extends ChangeNotifier {
  String name = '';
  String address = '';
  String phoneNumber = '';
  String pinCode = '';
  List<Product> cartItems = [];

  void updateName(String newName) {
    name = newName;
    notifyListeners();
  }

  void updateAddress(String newAddress) {
    address = newAddress;
    notifyListeners();
  }

  void updatePhoneNumber(String newPhoneNumber) {
    phoneNumber = newPhoneNumber;
    notifyListeners();
  }

  void updatePinCode(String newPinCode) {
    pinCode = newPinCode;
    notifyListeners();
  }

  void addItemToCart(Product product) {
    cartItems.add(product);
    notifyListeners();
  }

  void removeItemFromCart(Product product) {
    cartItems.remove(product);
    notifyListeners();
  }

  Future<void> generateInvoice(BuildContext context) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Invoice', style: pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 20),
              pw.Text('Name: $name'),
              pw.Text('Address: $address'),
              pw.Text('Phone Number: $phoneNumber'),
              pw.Text('Pin Code: $pinCode'),
              pw.SizedBox(height: 20),
              pw.Text('Cart Items:', style: pw.TextStyle(fontSize: 18)),
              pw.SizedBox(height: 10),
              ...cartItems.map((product) => pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('ID: ${product.id}, Name: ${product.name}'),
                      pw.Text('Price: \$${product.price.toStringAsFixed(2)}'),
                    ],
                  )),
              pw.SizedBox(height: 20),
              pw.Text(
                'Total: \$${cartItems.fold<double>(0.0, (sum, item) => sum + item.price).toStringAsFixed(2)}',
                style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
              ),
            ],
          );
        },
      ),
    );

    try {
      // Get the application documents directory
      final output = await getApplicationDocumentsDirectory();
      final file = File("${output.path}/invoice.pdf");

      // Write the PDF to the file
      await file.writeAsBytes(await pdf.save());

      // Notify the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invoice successfully generated at ${file.path}')),
      );
    } catch (e) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to generate invoice: $e')),
      );
    }
  }
}
