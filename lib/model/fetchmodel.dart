import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:white_matrix/model/productmodel.dart';

Future<List<ProductModel>> fetchProducts() async {
  final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('products').get();
  return snapshot.docs.map((doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProductModel.fromMap(data); 
  }).toList();
}
