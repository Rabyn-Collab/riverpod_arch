import 'package:flutterspod/constants/api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.g.dart';
part 'product.freezed.dart';

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
  final List<Review> reviews;

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
        reviews: (json['reviews'] as List).map((e) => Review.fromJson(e)).toList()
    );
  }

}


@freezed
class Review with _$Review{

  const factory Review({
   required String username,
   required String comment,
   required num rating,
   required String user,

  }) = _Review;

  factory Review.fromJson(Map<String, Object?> json) => _$ReviewFromJson(json);

}



