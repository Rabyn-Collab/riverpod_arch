import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/provider/auth_provider.dart';
import 'package:flutterspod/provider/product_provider.dart';
import 'package:flutterspod/views/main/detail_page.dart';
import 'package:flutterspod/views/main/user_page/cart_page.dart';
import 'package:flutterspod/views/main/widgets/drawer_widget.dart';
import 'package:get/get.dart';


class HomePage extends ConsumerWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
   final state = ref.watch(productProvider);
   final auth = ref.watch(authProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
       actions: [
         if(auth.user?.isAdmin != true) IconButton(onPressed: (){
           Get.to(() => CartPage(), transition:  Transition.leftToRight);
         }, icon: Icon(Icons.shopping_bag))
       ],
      ),
        drawer: DrawerWidget(ref:ref),
        body: state.when(
            data: (data){
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                  itemCount: data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      mainAxisSpacing: 7,
                      crossAxisSpacing: 7
                    ),
                    itemBuilder:(context, index){
                    final product = data[index];
                     return InkWell(
                       onTap: (){
                         Get.to(() => DetailPage(
                             user: auth.user,
                             product: product), transition: Transition.leftToRight);
                       },
                       child: GridTile(
                         header: Container(
                             color: Colors.black45,
                             child: Text(product.product_name)),
                           child: CachedNetworkImage(
                            // placeholder: (c,s) => Center(child: CircularProgressIndicator()),
                             imageUrl:product.product_image, fit: BoxFit.cover,),
                         footer: Container(
                           height: 30,
                           color: Colors.black45,
                           child: Center(child: Text('Rs.${product.product_price}')),
                         ),
                       ),
                     );
                    }
                ),
              );
            },
            error: (err, stack) => Center(child: Text('$err')),
            loading: () => Center(child: CircularProgressIndicator())
        )
    );
  }
}
