
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:white_matrix/controller/CheckoutController.dart';
import 'package:white_matrix/controller/cartcontroller.dart';
import 'package:white_matrix/controller/favcontroller.dart';
import 'package:white_matrix/controller/ordercontroller.dart';
import 'package:white_matrix/firebase_options.dart';
import 'package:white_matrix/view/OtpVerification/OtpVerificationScreen.dart';
import 'package:white_matrix/view/splashscreen/splashscreen.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
       
       
        ChangeNotifierProvider(
          create: (context) => SignUpController(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartController(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteController(),
        ),
        ChangeNotifierProvider(
          create: (context) => BookingController(),),
       ChangeNotifierProvider(create: (_) => CheckoutController()),
       ChangeNotifierProvider(create: (_) => AuthController()),
     
      
          
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:SignInScreen()
      ),
    );
  }
}
