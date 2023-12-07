

import 'package:hive_flutter/hive_flutter.dart';

part 'cart.g.dart';


@HiveType(typeId: 0)
class CartItem extends HiveObject{

  @HiveField(0)
  String name;

  @HiveField(1)
  int qty;

  @HiveField(2)
  String image;

  @HiveField(3)
  int  price;

  @HiveField(4)
  String product;


  CartItem({
    required this.name,
    required this.image,
    required this.product,
    required this.qty,
    required this.price,
});


  factory CartItem.empty(){
    return CartItem(
        name: 'no-data',
        image: '',
        product: '',
        qty: 0,
        price: 0
    );
  }


  Map<String, dynamic> get toMap {
   return {
     'name': this.name,
     'image': this.image,
     'product': this.product,
      'qty': this.qty,
     'price': this.price
     };
   }

}