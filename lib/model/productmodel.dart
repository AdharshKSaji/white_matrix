
class ProductModel {
  final String title;
  final String description;
  final dynamic image; 
  final String review;
  final String seller;
  final double originalPrice;
  final double rate;
  int quantity;

  ProductModel({
    required this.title,
    required this.description,
    required this.image,
    required this.review,
    required this.seller,
    required this.originalPrice,
    required this.rate,
    required this.quantity,
    required double price, 
  });

  

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'image': image,
      'review': review,
      'seller': seller,
      'price': originalPrice,
      'rate': rate,
      'quantity': quantity,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      title: map['title'],
      description: map['description'],
      image: map['image'],
      review: map['review'],
      seller: map['seller'],
      originalPrice: map['price'],
      rate: map['rate'],
      quantity: map['quantity'],
      price: map['price'], 
    );
  }
}
