import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/common_widgets/toast_widget.dart';
import 'package:flutterspod/main.dart';
import 'package:flutterspod/models/cart.dart';
import 'package:flutterspod/models/product.dart';
import 'package:hive_flutter/hive_flutter.dart';



final cartProvider = NotifierProvider<CartProvider, List<CartItem>>(() => CartProvider());

class CartProvider extends Notifier<List<CartItem>>{

  @override
 List<CartItem> build() {
    return ref.watch(boxB);
  }

  void addToCart(Product product, BuildContext context){
   final newsCart = CartItem(
       name: product.product_name,
       image: product.product_image,
       product: product.id,
       qty: 1,
       price: product.product_price
   );
   if(state.isEmpty){
    Hive.box<CartItem>('cartBox').add(newsCart);
    state = [...state, newsCart];
    Toasts.showSuccess(message: 'successfully added');
   }else{
      final isExist = state.firstWhere((element) => element.product == product.id, orElse: (){
       return CartItem.empty();
      });
      if(isExist.name == 'no-data'){
       Hive.box<CartItem>('cartBox').add(newsCart);
       state = [...state, newsCart];
       Toasts.showSuccess(message: 'successfully added');
      }else{
       Toasts.showError(message: 'product already added');
      }
   }
  }

  void addQuantity(CartItem cartItem){
    cartItem.qty = cartItem.qty + 1;
    cartItem.save();
    state = [
     for(final c in state) c.product == cartItem.product ? cartItem: c
    ];
  }

  void removeQuantity(CartItem cartItem){
    if(cartItem.qty > 1){
     cartItem.qty = cartItem.qty - 1;
     cartItem.save();
     state = [
      for(final c in state) c.product == cartItem.product ? cartItem: c
     ];
    }
  }



  void singleRemove(CartItem cartItem){
   state.remove(cartItem);
   state = [...state];
  }


  int get total {
    int total = 0;
    state.forEach((element) {
      total += element.qty * element.price;
    });
    return total;
  }


  void clearAll(){
   Hive.box<CartItem>('cartBox').clear();
   state = [];
  }




}