// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:white_matrix/controller/CheckoutController.dart';
// import 'package:white_matrix/view/paymentscreen/paymentscreen.dart';

// class CheckoutScreen extends StatelessWidget {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController pinCodeController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<CheckoutController>(
//       create: (_) => CheckoutController(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Checkout', style: TextStyle(color: Colors.white)),
//           backgroundColor: Colors.deepPurple,
//           centerTitle: true,
//         ),
//         body: Consumer<CheckoutController>(
//           builder: (context, controller, child) {
//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _buildTextField(
//                       label: 'Name',
//                       controller: nameController,
//                       icon: Icons.person,
//                       onChanged: controller.updateName,
//                     ),
//                     SizedBox(height: 10),
//                     _buildTextField(
//                       label: 'Delivery Address',
//                       controller: addressController,
//                       icon: Icons.location_on,
//                       onChanged: controller.updateAddress,
//                     ),
//                     SizedBox(height: 10),
//                     _buildTextField(
//                       label: 'Phone Number',
//                       controller: phoneController,
//                       icon: Icons.phone,
//                       keyboardType: TextInputType.phone,
//                       onChanged: controller.updatePhoneNumber,
//                     ),
//                     SizedBox(height: 10),
//                     _buildTextField(
//                       label: 'Pin Code',
//                       controller: pinCodeController,
//                       icon: Icons.lock,
//                       keyboardType: TextInputType.number,
//                       onChanged: controller.updatePinCode,
//                     ),
                
//                     SizedBox(height: 10),
//                     _buildCartItemsList(controller),
//                     SizedBox(height: 20),
//                     _buildButtonRow(context, controller),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required String label,
//     required TextEditingController controller,
//     required IconData icon,
//     required ValueChanged<String> onChanged,
//     TextInputType keyboardType = TextInputType.text,
//   }) {
//     return TextField(
//       controller: controller,
//       keyboardType: keyboardType,
//       decoration: InputDecoration(
//         labelText: label,
//         prefixIcon: Icon(icon, color: Colors.deepPurple),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide(color: Colors.deepPurple),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide(color: Colors.deepPurple, width: 2),
//         ),
//       ),
//       onChanged: onChanged,
//     );
//   }

//   Widget _buildCartItemsList(CheckoutController controller) {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       itemCount: controller.cartItems.length,
//       itemBuilder: (context, index) {
//         final product = controller.cartItems[index];
//         return Card(
//           elevation: 4,
//           margin: EdgeInsets.symmetric(vertical: 5),
//           child: ListTile(
//             leading: Icon(Icons.shopping_cart, color: Colors.deepPurple),
//             title: Text(product.name),
//             subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
//             trailing: IconButton(
//               icon: Icon(Icons.delete, color: Colors.red),
//               onPressed: () {
//                 controller.removeItemFromCart(product);
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildButtonRow(BuildContext context, CheckoutController controller) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         ElevatedButton.icon(
//           onPressed: () async {
//            Navigator.push(context, MaterialPageRoute(builder: 
//            (context) => Payment(),));
//             await controller.generateInvoice(context);
//           },
//           icon: Icon(Icons.payment),
//           label: Text('Payment',style: TextStyle(color: Colors.white),),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.black,
//             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//             textStyle: TextStyle(fontSize: 16),
//           ),
//         ),
//       ],
//     );
//   }
// }
