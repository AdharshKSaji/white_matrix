import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter/material.dart';

class PaymentController {
  final Razorpay _razorpay = Razorpay();

  PaymentController() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentErrorResponse);
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccessResponse);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWalletSelected);
  }

  void initiatePayment(double amount) {
    var options = {
      'key': 'rzp_live_ILgsfZCZoFIKMb',
      'amount': amount * 100, // Amount in paise
      'name': 'My Shoppy',
      'description': 'Car Rental Services',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {
        'contact': '919562106384',
        'email': 'adharshksaji001@com',
        'place': 'Kochi, Kerala'
      },
      'external': {
        'wallets': ['paytm', 'Gpay']
      }
    };
    _razorpay.open(options);
  }

  void _handlePaymentErrorResponse(PaymentFailureResponse response) {
    // Handle payment error
  }

  void _handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    // Handle payment success
  }

  void _handleExternalWalletSelected(ExternalWalletResponse response) {
    // Handle external wallet selection
  }

  void dispose() {
    _razorpay.clear();
  }
}
