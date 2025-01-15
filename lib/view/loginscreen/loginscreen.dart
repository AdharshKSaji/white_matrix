// import 'package:ewaste/View/Home/Home.dart';
// import 'package:ewaste/View/SignUP/Signup.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:provider/provider.dart';


// class AuthController extends ChangeNotifier {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   Future<void> signIn(String email, String password, BuildContext context) async {
//     try {
//       await _auth.signInWithEmailAndPassword(email: email, password: password);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Successfully signed in!")),
//       );
//        Navigator.push(context, 
//                   MaterialPageRoute(builder: (context) => HomeScreen()));
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error: ${e.toString()}")),
//       );
//     }
//   }
// }

// class SignInScreen extends StatelessWidget {
//   const SignInScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<AuthController>(context, listen: false);
//     final _emailController = TextEditingController();
//     final _passwordController = TextEditingController();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Sign In"),
//         centerTitle: true,
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color.fromARGB(255, 233, 169, 72), Color.fromARGB(255, 235, 122, 114)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 "Sign In",
//                 style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
//               ),
//               const SizedBox(height: 30),
//               _buildTextField("Email", _emailController),
//               const SizedBox(height: 15),
//               _buildTextField("Password", _passwordController, obscureText: true),
//               const SizedBox(height: 30),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   foregroundColor: Colors.blue,
//                   padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                   backgroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//                 ),
//                 onPressed: () {
//                   authProvider.signIn(
//                     _emailController.text.trim(),
//                     _passwordController.text.trim(),
//                     context,
//                   );
//                 },
//                 child: const Text("Sign In", style: TextStyle(fontSize: 18)),
//               ),
//               const SizedBox(height: 20),
//               TextButton(
//                 onPressed: () {
//                   Navigator.push(context, 
//                   MaterialPageRoute(builder: (context) => SignUpScreen(),));
//                 },
//                 child: const Text(
//                   "Don't have an account? Sign Up",
//                   style: TextStyle(color: Colors.white, fontSize: 16),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(String hint, TextEditingController controller, {bool obscureText = false}) {
//     return TextField(
//       controller: controller,
//       decoration: InputDecoration(
//         hintText: hint,
//         filled: true,
//         fillColor: Colors.white,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(30),
//           borderSide: BorderSide.none,
//         ),
//       ),
//       obscureText: obscureText,
//     );
//   }
// }

