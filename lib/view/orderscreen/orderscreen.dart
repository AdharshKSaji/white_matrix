// import 'package:flutter/material.dart';

// import 'package:white_matrix/controller/cartcontroller.dart';

// class Orderscreen extends StatefulWidget {
//   Orderscreen({super.key});

//   @override
//   State<Orderscreen> createState() => _OrderscreenState();
// }

// class _OrderscreenState extends State<Orderscreen> {
//   @override
//   Widget build(BuildContext context) {
//     final cartController = CartController.of(context);
//     final cartItems = cartController.cartItems;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: Text(
//           "My Orders",
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: cartItems.length,
//                 itemBuilder: (context, index) {
//                   final item = cartItems[index];
//                   return Stack(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.all(15.0),
//                         child: Container(
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           padding: EdgeInsets.all(20),
//                           child: Row(
//                             children: [
//                               Container(
//                                 height: 100,
//                                 width: 90,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                                 padding: EdgeInsets.all(10),
//                                 child: Image.network(
//                                   item.image,
//                                   fit: BoxFit.fill,
//                                 ),
//                               ),
//                               SizedBox(width: 10),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     item.title,
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   SizedBox(height: 5),
//                                   Text(
//                                     "\₹${item.price}",
//                                     style: TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Positioned(
//                         top: 35,
//                         right: 35,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             SizedBox(height: 10),
//                             Container(
//                               height: 40,
//                               decoration: BoxDecoration(
//                                 color: Colors.blue,
//                                 border: Border.all(
//                                   color: Colors.grey.shade200,
//                                   width: 2,
//                                 ),
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                               child: Row(
//                                 children: [
//                                   SizedBox(width: 10),
//                                   Text(
//                                     "${item.quantity}",
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   SizedBox(width: 10),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(height: 20),
//                             GestureDetector(
//                               onTap: () {
//                                 // Navigator.push(
//                                 //   context,
//                                 //   MaterialPageRoute(
//                                 //     builder: (context) => TrackOrderScreen(),
//                                 //   ),
//                                 // );
//                               },
//                               child: Container(
//                                 height: 40,
//                                 decoration: BoxDecoration(
//                                   color: Colors.amber,
//                                   border: Border.all(
//                                     color: Colors.grey.shade200,
//                                     width: 2,
//                                   ),
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     SizedBox(width: 10),
//                                     Text(
//                                       "Track order",
//                                       style: TextStyle(
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     SizedBox(width: 10),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
