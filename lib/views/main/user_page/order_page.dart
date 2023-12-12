import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/common_widgets/toast_widget.dart';
import 'package:flutterspod/constants/app_sizes.dart';
import 'package:flutterspod/provider/auth_provider.dart';
import 'package:flutterspod/provider/cart_provider.dart';
import 'package:flutterspod/provider/order_provider.dart';
import 'package:flutterspod/views/main/home_page.dart';
import 'package:get/get.dart';



class OrderPage extends ConsumerWidget {

  const OrderPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final carts = ref.watch(cartProvider);
    final total = ref.watch(cartProvider.notifier).total;
    final auth = ref.watch(authProvider);
    final state = ref.watch(orderNotifier);

    ref.listen(orderNotifier, (previous, next) {
      if(next.isError){
        Toasts.showError(message: next.errMsg);
      }else if(next.isSuccess){
        Get.offAll(() => HomePage(), transition: Transition.leftToRight);
        Toasts.showSuccess(message: 'successfully order placed');
      }
    });

    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppSizes.gapH20,
                AppSizes.gapH20,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Shipping Address:-', style: TextStyle(fontSize: 17),),
                      Row(
                        children: [
                          Text(auth.user!.shippingAddress.address + ' , ', style: TextStyle(color: Colors.pink),),
                          Text(auth.user!.shippingAddress.city, style: TextStyle(color: Colors.purple),),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(carts.map((e) =>e.toMap).toList().toString()),
                      ),
                    ],
                  ),
                ),
                Text('Total:- ${total}'),
                AppSizes.gapH10,
                AppSizes.gapH10,
                AppSizes.gapH10,
                ElevatedButton(
                    onPressed: state.isLoading ? null: (){
                  ref.read(orderNotifier.notifier).addOrder(orderItems: carts.map((e) => e.toMap).toList(), totalPrice: total);
                }, child: state.isLoading ? Center(child: CircularProgressIndicator()) :Text('CheckOut'))



              ],
            ),
          ),
        )
    );
  }
}
