



import 'package:flutterspod/constants/api.dart';

class Product{

  final String id;
  final String product_name;
  final String product_detail;
  final int product_price;
  final String rating;
  final  int numReviews;
  final String product_image;
    final String brand;
  final String category;
  final  int countInStock;
  final List reviews;

  Product({
    required this.rating,
    required this.id,
    required this.brand,
    required this.category,
    required this.countInStock,
    required this.numReviews,
    required this.product_detail,
    required this.product_image,
    required this.product_name,
    required this.product_price,
    required this.reviews
});


  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
        rating: json['rating'].toString(),
        id: json['_id'],
        brand: json['brand'],
        category: json['category'],
        countInStock: json['countInStock'],
        numReviews: json['numReviews'],
        product_detail: json['product_detail'],
        product_image: '${Api.baseUrl}${json['product_image']}',
        product_name: json['product_name'],
        product_price: json['product_price'],
        reviews: json['reviews']
    );
  }

}