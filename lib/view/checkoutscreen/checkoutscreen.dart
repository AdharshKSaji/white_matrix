import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:white_matrix/controller/CheckoutController.dart';
import 'package:white_matrix/view/paymentscreen/paymentscreen.dart';

class CheckoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CheckoutController>(
      create: (_) => CheckoutController(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Checkout', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
        ),
        body: Consumer<CheckoutController>(
          builder: (context, controller, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField(
                      label: 'Name',
                      initialValue: controller.name,
                      icon: Icons.person,
                      onChanged: (value) => controller.updateName(value),
                    ),
                    SizedBox(height: 10),
                    _buildTextField(
                      label: 'Delivery Address',
                      initialValue: controller.address,
                      icon: Icons.location_on,
                      onChanged: (value) => controller.updateAddress(value),
                    ),
                    SizedBox(height: 10),
                    _buildTextField(
                      label: 'Phone Number',
                      initialValue: controller.phoneNumber,
                      icon: Icons.phone,
                      keyboardType: TextInputType.phone,
                      onChanged: (value) => controller.updatePhoneNumber(value),
                    ),
                    SizedBox(height: 10),
                    _buildTextField(
                      label: 'Pin Code',
                      initialValue: controller.pinCode,
                      icon: Icons.lock,
                      keyboardType: TextInputType.number,
                      onChanged: (value) => controller.updatePinCode(value),
                    ),
                    SizedBox(height: 10),
                    _buildCartItemsList(controller),
                    SizedBox(height: 20),
                    _buildButtonRow(context, controller),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String initialValue,
    required IconData icon,
    required ValueChanged<String> onChanged,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: TextEditingController(text: initialValue),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.deepPurple),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.deepPurple),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.deepPurple, width: 2),
        ),
      ),
      onChanged: onChanged,
    );
  }

  Widget _buildCartItemsList(CheckoutController controller) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: controller.cartItems.length,
      itemBuilder: (context, index) {
        final cartItem = controller.cartItems[index];
        return Card(
          elevation: 4,
          margin: EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            leading: Icon(Icons.shopping_cart, color: Colors.deepPurple),
            title: Text(cartItem.product.title),
            subtitle: Text('\$${cartItem.product.price.toStringAsFixed(2)} x ${cartItem.quantity}'),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                controller.removeItemFromCart(cartItem.product);
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildButtonRow(BuildContext context, CheckoutController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Payment()),
            );
          },
          icon: Icon(Icons.payment),
          label: Text('Payment', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            textStyle: TextStyle(fontSize: 16),
          ),
        ),
        SizedBox(width: 10), 
        ElevatedButton.icon(
          onPressed: () {
            _generateAndShareInvoice(context, controller);
          },
          icon: Icon(Icons.download),
          label: Text('Download Invoice', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            textStyle: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Future<void> _generateAndShareInvoice(BuildContext context, CheckoutController controller) async {
    final invoiceContent = _generateInvoiceContent(controller);
    final pdfFile = await _createPdf(invoiceContent);

    // Save the file to the device's storage
    final downloadsDirectory = await getExternalStorageDirectory();
    final filePath = '${downloadsDirectory!.path}/invoice_${DateTime.now().millisecondsSinceEpoch}.pdf';
    await pdfFile.copy(filePath);

    // Display a dialog with share and open options
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Invoice'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Invoice has been generated.'),
              SizedBox(height: 10),
              Text('File saved at:'),
              Text(filePath, style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Share.share(invoiceContent, subject: 'Invoice');
              },
              child: Text('Share'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Future<File> _createPdf(String content) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text(content),
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/invoice_temp.pdf');
    await file.writeAsBytes(await pdf.save());

    return file;
  }

  String _generateInvoiceContent(CheckoutController controller) {
    final transactionNumber = DateTime.now().millisecondsSinceEpoch;
    final buffer = StringBuffer();

    buffer.writeln('Invoice');
    buffer.writeln('Transaction Number: $transactionNumber');
    buffer.writeln('Name: ${controller.name}');
    buffer.writeln('Address: ${controller.address}');
    buffer.writeln('Phone: ${controller.phoneNumber}');
    buffer.writeln('Pin Code: ${controller.pinCode}');
    buffer.writeln('Cart Items:');

    for (var item in controller.cartItems) {
      buffer.writeln('${item.product.title} - \$${item.product.price.toStringAsFixed(2)} x ${item.quantity}');
    }

    buffer.writeln('Total: \$${controller.totalPrice.toStringAsFixed(2)}');

    return buffer.toString();
  }
}
