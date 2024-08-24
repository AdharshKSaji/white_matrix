import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:white_matrix/controller/ordercontroller.dart';
import 'package:white_matrix/view/homescreen/homescreen.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    double amount = context.read<BookingController>().totalPrice();

    return Scaffold(
      appBar: AppBar(leading:  IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },),
        title: Text(
          'Book Here',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 5,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
               
                Image.asset(
                  'assets/images/undraw_mobile_pay_re_sjb8.jpg', 
                  height: 150, 
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 20), 
                
                SizedBox(height: 20),
                _buildPaymentOptions(context, amount),
              ],
            ),
          ),
          SizedBox(height: 60),
        ],
      ),
      backgroundColor: Colors.grey[100],
    );
  }

  
  Widget _buildPaymentOptions(BuildContext context, double amount) {
    return Column(
      children: [
     _buildOptionButton(
  context,
  "Cash on Delivery",
  Colors.green,
  () {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
      (route) => false,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Booked Successfully!"),
        duration: Duration(seconds: 3), 
        backgroundColor: Colors.green,
      ),
    );
  },
),
        SizedBox(height: 20),
        _buildOptionButton(
          context,
          "Online Payment",
          Colors.deepPurple,
          () => _initiatePayment(amount),
        ),
      ],
    );
  }

  Widget _buildOptionButton(
    BuildContext context,
    String text,
    Color color,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: Size(double.infinity, 55),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.symmetric(vertical: 15),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  void _initiatePayment(double amount) {
    Razorpay razorpay = Razorpay();
    var options = {
      'key': 'rzp_live_ILgsfZCZoFIKMb',
      'amount': amount * 100,
      'name': 'My Shoppy',
      'description': 'Car Rental Services',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {
        'contact': '919847452792',
        'email': 'adharshksaji001@com',
        'place': 'Kochi, Kerala'
      },
      'external': {
        'wallets': ['paytm', 'Gpay']
      }
    };
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
    razorpay.open(options);
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    showAlertDialog(
      context,
      "Payment Failed",
      "Code: ${response.code}\nDescription: ${response.message}\nMetadata: ${response.error.toString()}",
    );
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    showAlertDialog(
      context,
      "Order Placed Successfully",
      "Payment ID: ${response.paymentId}",
    );
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
      context,
      "External Wallet Selected",
      "${response.walletName}",
    );
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    AlertDialog alert = AlertDialog(
      title: Text(title, style: TextStyle(color: Colors.deepPurple)),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            "OK",
            style: TextStyle(color: Colors.deepPurple),
          ),
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
