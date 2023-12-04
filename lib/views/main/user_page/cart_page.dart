import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/constants/app_sizes.dart';
import 'package:flutterspod/provider/cart_provider.dart';
import 'package:lottie/lottie.dart';



class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final cartItems = ref.watch(cartProvider);
    final total = ref.watch(cartProvider.notifier).total;
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: cartItems.isEmpty ?Column(
              children: [
                Lottie.asset('assets/json/ani.json'),
                Text('Add Some Products')
              ],
            ): Column(
              children: [
                AppSizes.gapH20,
                Expanded(
                    child:ListView.builder(
                      itemCount: cartItems.length,
                        itemBuilder: (context, index){
                        final cart = cartItems[index];
                        return Stack(
                          children: [
                            Row(
                              children: [
                              Expanded(child: Image.network(cart.image, fit: BoxFit.fill, height: 170,)),
                                AppSizes.gapW16,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(cart.name),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 20),
                                        child: Text('${cart.qty } X Rs. ${cart.price}'),
                                      ),
                                      Row(
                                        children: [
                                          OutlinedButton(onPressed: (){
                                            ref.read(cartProvider.notifier).addQuantity(cart);
                                          }, child: Icon(Icons.add)),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10),
                                            child: Text('${cart.qty}', style: TextStyle(fontSize: 17),),
                                          ),
                                          OutlinedButton(onPressed: (){
                                            ref.read(cartProvider.notifier).removeQuantity(cart);
                                          }, child: Icon(Icons.remove)),
                                        ],
                                      )

                                    ],
                                  ),
                                ),

                              ],
                            ),
                            Positioned(
                                right: 0,
                                child: IconButton(onPressed: (){
                                  ref.read(cartProvider.notifier).singleRemove(cart);
                                }, icon: Icon(Icons.close)))
                          ],
                        );
                        }
                    )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total:-'),
                    Text('Rs. $total')
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ElevatedButton(onPressed: (){
                    ref.read(cartProvider.notifier).clearAll();
                  }, child: Text('place an order')),
                ),
              ],
            ),
          ),
        )
    );
  }
}
