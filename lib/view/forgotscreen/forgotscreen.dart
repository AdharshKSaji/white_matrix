// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:spiceway/constants/colorconstants.dart/colorconstants.dart';
// import 'package:spiceway/view/loginscreen/loginscreen.dart';

// class ForgotScreen extends StatefulWidget {
//   const ForgotScreen({super.key});

//   @override
//   State<ForgotScreen> createState() => _ForgotScreenState();
// }

// class _ForgotScreenState extends State<ForgotScreen> {
//   TextEditingController mailcontroller = TextEditingController();
//   String email = "";
//   final formkey = GlobalKey<FormState>();
//   resetpassword() async {
//     try {
//       await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
//       ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("password reset has been sent!")));
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text("no user found")));
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: ColorConstants.primaryGreen,
//       ),
//       backgroundColor: ColorConstants.primaryGreen,
//       body: Container(
//         child: Column(
//           children: [
//             SizedBox(
//               height: 70,
//             ),
//             Container(
//               alignment: Alignment.topCenter,
//               child: Text(
//                 "password recovery",
//                 style: TextStyle(
//                     color: ColorConstants.primaryBlack,
//                     fontSize: 30.0,
//                     fontWeight: FontWeight.bold),
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Text("enter your mail"),
//             Expanded(
//                 child: Form(
//               key: formkey,
//               child: Padding(
//                 padding: EdgeInsets.only(left: 10),
//                 child: ListView(
//                   children: [
//                     Container(
//                       padding: EdgeInsets.only(left: 10),
//                       decoration: BoxDecoration(
//                           border: Border.all(
//                             color: ColorConstants.primarWhite,
//                           ),
//                           borderRadius: BorderRadius.circular(30)),
//                       child: TextFormField(
//                         controller: mailcontroller,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return "please enter email";
//                           }
//                           return null;
//                         },
//                         decoration: InputDecoration(
//                           hintText: "E-mail",
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 40,
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         if (formkey.currentState!.validate()) {
//                           setState(() {
//                             email = mailcontroller.text;
//                           });
//                           resetpassword();
//                         }
//                       },
//                       child: Container(
//                         width: 140,
//                         padding: EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                             color: ColorConstants.primarWhite,
//                             borderRadius: BorderRadius.circular(10)),
//                         child: Center(
//                           child: Text(
//                             "sent email",
//                             style: TextStyle(
//                               fontSize: 18,
//                             ),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             )),
//             TextButton(
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => LoginScreen(),
//                       ));
//                 },
//                 child: Text("login"))
//           ],
//         ),
//       ),
//     );
//   }
// }
