import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:white_matrix/controller/CheckoutController.dart';
import 'package:white_matrix/view/paymentscreen/paymentscreen.dart';

class CheckoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CheckoutController>(
      create: (_) => CheckoutController(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
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
                      controller: controller.nameController,
                    ),
                    SizedBox(height: 10),
                    _buildTextField(
                      label: 'Delivery Address',
                      controller: controller.addressController,
                    ),
                    SizedBox(height: 10),
                    _buildTextField(
                      label: 'Phone Number',
                      controller: controller.phoneNumberController,
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 10),
                    _buildTextField(
                      label: 'Pin Code',
                      controller: controller.pinCodeController,
                      keyboardType: TextInputType.number,
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
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.deepPurple),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.deepPurple, width: 2),
        ),
      ),
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
            subtitle: Text('\$${cartItem.product.originalPrice.toStringAsFixed(2)} x ${cartItem.quantity}'),
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

    // Display a dialog with share, print, and open options
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
                Share.share(filePath, subject: 'Invoice');
              },
              child: Text('Share'),
            ),
            TextButton(
              onPressed: () async {
                await Printing.layoutPdf(
                  onLayout: (PdfPageFormat format) async {
                    final pdf = pw.Document();
                    pdf.addPage(
                      pw.Page(
                        pageFormat: format,
                        build: (pw.Context context) {
                          return pw.Center(
                            child: pw.Text(invoiceContent),
                          );
                        },
                      ),
                    );
                    return pdf.save();
                  },
                );
                Navigator.of(context).pop();
              },
              child: Text('Print'),
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

    buffer.writeln('          INVOICE');
    buffer.writeln('==============================');
    buffer.writeln('');
    buffer.writeln('Transaction Number: $transactionNumber');
    buffer.writeln('Date: ${DateTime.now().toLocal().toString()}');
    buffer.writeln('');
    buffer.writeln('Customer Details:');
    buffer.writeln('Name: ${controller.name}');
    buffer.writeln('Address: ${controller.address}');
    buffer.writeln('Phone: ${controller.phoneNumber}');
    buffer.writeln('Pin Code: ${controller.pinCode}');
    buffer.writeln('');
    for (var item in controller.cartItems) {
      buffer.writeln('${item.product.title.padRight(20)} \$${item.product.originalPrice.toStringAsFixed(2).padLeft(8)} x ${item.quantity}');
    }
    buffer.writeln('------------------------------');
    buffer.writeln('Total: ${controller.totalPrice.toStringAsFixed(2)}');
    buffer.writeln('');
    buffer.writeln('==============================');
    buffer.writeln('Thank you for your purchase!');

    return buffer.toString();
  }
}
