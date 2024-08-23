// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:white_matrix/controller/AuthController.dart';
import 'package:white_matrix/view/OtpVerification/OtpVerificationScreen.dart';


class LoginController extends ChangeNotifier {
  final TextEditingController phoneNumberController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void sendOtp(BuildContext context) {
    if (formKey.currentState!.validate()) {
      final authViewModel = Provider.of<Authcontroller>(context, listen: false);
      final phoneNumber = '+91${phoneNumberController.text}';
      authViewModel.sendOtp(phoneNumber);
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => OtpVerificationScreen(
          phoneNumber: phoneNumber,
          verificationId: "",
        ),
      ));
    }
  }
}