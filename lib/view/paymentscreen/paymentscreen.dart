
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:white_matrix/controller/ordercontroller.dart';
import 'package:white_matrix/view/homescreen/homescreen.dart';



class payment extends StatefulWidget {
  const payment({super.key});

  @override
  State<payment> createState() => _paymentState();
}

class _paymentState extends State<payment> {
  @override
  Widget build(BuildContext context) {
    double amount = context.read<BookingController>().totalPrice();
    // final provider = Cartcontroller.of(context);
    return Scaffold(appBar: AppBar(),
      body:  Column( mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
            ),
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "\₹${amount}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Razorpay razorpay = Razorpay();
                    var options = {
                      'key': 'rzp_live_ILgsfZCZoFIKMb',
                      'amount': amount * 100,
                      'name': 'My Shoppy',
                      'description': 'Car Rental Servies',
                      'retry': {'enabled': true, 'max_count': 1},
                      'send_sms_hash': true,
                      'prefill': {
                        'contact': '919562106384',
                        'email': 'adharshksaji001@com',
                        'place': 'Kochi,Kerala'
                      },
                      'external': {
                        'wallets': ['paytm','Gpay']
      
                      }
                    };
                    razorpay.on(
                        Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
                    razorpay.on(
                        Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
                    razorpay.on(
                        Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
                    razorpay.open(options);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: Size(double.infinity, 55),
                  ),
                  child: Text(
                    "Proceed to pay",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),SizedBox(height: 60,),


          Column(
            children: [
              Text("​​​​​​​​​​​​Cash on Delivery(COD), "),
              SizedBox(height: 20),
              Text("Press Skip Button to return homepage"),
            ],
          ),
          SizedBox(height: 30),
          ElevatedButton(onPressed: () {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
              builder: (context) => HomeScreen(),), (route) => false);
            
          }, child: Text("Skip Payment"))
        ],
      ),
    );
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    showAlertDialog(context, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    showAlertDialog(context, "Order Placed Successfully",
        "Payment ID: ${response.paymentId}");
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
