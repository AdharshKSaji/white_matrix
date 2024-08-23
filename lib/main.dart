import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:white_matrix/controller/AuthController.dart';
import 'package:white_matrix/controller/CheckoutController.dart';
import 'package:white_matrix/controller/cartcontroller.dart';
import 'package:white_matrix/controller/favcontroller.dart';
import 'package:white_matrix/controller/logincontroller.dart';
import 'package:white_matrix/controller/ordercontroller.dart';
import 'package:white_matrix/firebase_options.dart';
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
          create: (context) => LoginController(),
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
       ChangeNotifierProvider(create: (_) => Authcontroller())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SplashScreen(
                islogged: true,
              );
            } else {
              return SplashScreen(
                islogged: false,
              );
            }
          },
        ),
      ),
    );
  }
}
