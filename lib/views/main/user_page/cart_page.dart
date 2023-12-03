import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/provider/cart_provider.dart';



class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final cartItems = ref.watch(cartProvider);
    final total = ref.watch(cartProvider.notifier).total;
    return Scaffold(
        body: Column(
          children: [
            ElevatedButton(onPressed: (){}, child: Text('place an order')),
          ],
        )
    );
  }
}
