import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/constants/app_sizes.dart';
import 'package:flutterspod/models/user.dart';
import 'package:flutterspod/provider/cart_provider.dart';

import '../../models/product.dart';



class DetailPage extends StatelessWidget {
  final Product product;
  final User? user;
  const DetailPage({super.key, required this.product, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Image.network(product.product_image),
            AppSizes.gapH20,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.product_name),
                  Text(product.product_detail),
                ],
              ),
            ),
           if(user?.isAdmin == false) Consumer(
             builder: (context, ref, child) {

               return ElevatedButton(
                   onPressed: () {
                      ref.read(cartProvider.notifier).addToCart(product, context);
                   }, child: Text('Add To Cart'));
             }
           ),
            AppSizes.gapH20,
          ],
        )
    );
  }
}
