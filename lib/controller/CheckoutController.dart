import 'dart:convert'; // For json encoding
import 'dart:io'; // For file operations
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart'; // For getting the file path
import 'package:pdf/pdf.dart'; // For PDF generation
import 'package:pdf/widgets.dart' as pw; // For PDF widgets

class CheckoutController extends ChangeNotifier {
  String _name = '';
  String _address = '';
  String _phoneNumber = '';
  String _pinCode = '';
  List<String> _cartItems = [];

  String get name => _name;
  String get address => _address;
  String get phoneNumber => _phoneNumber;
  String get pinCode => _pinCode;
  List<String> get cartItems => _cartItems;

  void updateName(String value) {
    _name = value;
    notifyListeners();
  }

  void updateAddress(String value) {
    _address = value;
    notifyListeners();
  }

  void updatePhoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }

  void updatePinCode(String value) {
    _pinCode = value;
    notifyListeners();
  }

  void addItemToCart(String item) {
    _cartItems.add(item);
    notifyListeners();
  }

  void removeItemFromCart(String item) {
    _cartItems.remove(item);
    notifyListeners();
  }

  Future<void> checkout() async {
    // Generate invoice
    final invoiceFile = await _generateInvoice();
    // You can now save or use this file as needed
    print('Invoice saved at: ${invoiceFile.path}');
    // Implement your checkout logic
  }

  Future<File> _generateInvoice() async {
    final pdf = pw.Document();
    
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Invoice'),
              pw.Text('Name: $_name'),
              pw.Text('Address: $_address'),
              pw.Text('Phone Number: $_phoneNumber'),
              pw.Text('Pin Code: $_pinCode'),
              pw.Text('Cart Items:'),
              pw.Column(
                children: _cartItems.map((item) => pw.Text(item)).toList(),
              ),
            ],
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/invoice.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }
}
