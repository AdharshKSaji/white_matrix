import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:scratcher/scratcher.dart';
import 'package:white_matrix/controller/OtpVerficationController.dart';
import 'package:white_matrix/view/homescreen/homescreen.dart';

class OtpVerificationScreen extends StatelessWidget {
  final String phoneNumber;
  final String verificationId;

  const OtpVerificationScreen({
    super.key,
    required this.phoneNumber,
    required this.verificationId,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final controller = OtpVerificationController();
        controller.setVerificationId(verificationId);
        return controller;
      },
      child: Consumer<OtpVerificationController>(
        builder: (context, controller, child) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        "assets/images/otp.svg",
                        height: 150,
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "OTP Verification",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        "Enter the verification code we just sent to your number $phoneNumber",
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 20.0),
                      Pinput(
                        length: 6,
                        controller: controller.otpController,
                        onChanged: controller.updateOtp,
                        onCompleted: (pin) async {
                          await controller.verifyOtp();
                          if (controller.errorMessage.isEmpty) {
                            _showScratchCardDialog(context);
                          }
                        },
                        defaultPinTheme: PinTheme(
                          width: 56,
                          height: 56,
                          textStyle: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: Colors.grey),
                          ),
                        ),
                        errorPinTheme: PinTheme(
                          decoration: BoxDecoration(
                            color: Colors.red.shade100,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: Colors.red),
                          ),
                        ),
                      ),
                      if (controller.errorMessage.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            controller.errorMessage,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't get OTP? ",
                            style: TextStyle(fontSize: 14),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.resendOtp(phoneNumber);
                            },
                            child: const Text(
                              "Resend",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller.verifyOtp();
                            if (controller.errorMessage.isEmpty) {
                              _showScratchCardDialog(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                          ),
                          child: const Text(
                            'Verify',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showScratchCardDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 200.0,
            child: Scratcher(
              brushSize: 50,
              threshold: 50,
              color: Colors.blueGrey,
              onChange: (value) {
                print("Scratch progress: $value%");
              },
              onThreshold: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (route) => false,
                );
              },
              child: Container(
                alignment: Alignment.center,
                color: Colors.white,
                child: const Text(
                  "Congratulations!\nYou have verified the OTP!",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
