import 'package:white_matrix/model/productmodel.dart';


class CartModel {
  ProductModel product;
  int qty;
  CartModel({required this.product, this.qty = 1});
}