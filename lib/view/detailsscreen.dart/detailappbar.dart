
// import 'package:flutter/material.dart';
// import 'package:white_matrix/controller/favcontroller.dart';

// class DetailAppBar extends StatelessWidget {
//   final ProductModel ;

//   const DetailAppBar({super.key, this.ProductModel});

//   @override
//   Widget build(BuildContext context) {
//     final provider = Favoritecontroller.of(context);
//     return Padding(
//       padding: const EdgeInsets.all(10),
//       child: Row(
//         children: [
//           IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: const Icon(Icons.arrow_back_ios),
//           ),
//           const CircleAvatar(
//             radius: 30,
//             backgroundImage: AssetImage("assets/enoikiou-high-resolution-logo-white.jpg"),
//           ),
//           const Spacer(),
//           IconButton(
//             style: IconButton.styleFrom(
//               backgroundColor: Colors.white,
//               padding: const EdgeInsets.all(15),
//             ),
//             onPressed: () {
//               // Add share functionality here
//             },
//             icon: const Icon(Icons.share_outlined),
//           ),
//           const SizedBox(width: 10),
//           IconButton(
//             style: IconButton.styleFrom(
//               backgroundColor: Colors.white,
//               padding: const EdgeInsets.all(15),
//             ),
//             onPressed: () {
//               provider.toggleFavorite(ProductModel);
//             },
//             icon: Icon(
//               provider.isExist(ProductModel)
//                   ? Icons.favorite
//                   : Icons.favorite_border,
//               color: Colors.blue,
//               size: 22,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
