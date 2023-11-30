import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/provider/product_provider.dart';
import 'package:flutterspod/views/main/admin_page/add_form.dart';
import 'package:flutterspod/views/main/admin_page/edit_form.dart';
import 'package:get/get.dart';



class ProductList extends ConsumerWidget{
  const ProductList({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(productProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text('Product Lists'),
          actions: [
            IconButton(onPressed: (){
              Get.to(() => AddForm(), transition:  Transition.leftToRight);
            }, icon: Icon(Icons.add))
          ],
        ),

        body: state.when(
            data: (data){
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.separated(
                  separatorBuilder: (c, i){
                    return Divider(height: 25,);
                  },
                    itemCount: data.length,

                    itemBuilder:(context, index){
                      final product = data[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(product.product_name),
                        leading: CachedNetworkImage(
                          imageUrl:product.product_image,
                          width: 100,
                          fit: BoxFit.cover,),
                        trailing: Container(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(onPressed: (){
                                Get.to(() => EditForm(product: product));
                              }, icon: Icon(Icons.edit)),
                              IconButton(onPressed: (){}, icon: Icon(Icons.delete)),
                            ],
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
