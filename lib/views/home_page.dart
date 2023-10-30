import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterspod/provider/api_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutterspod/views/detail_page.dart';
import 'package:get/get.dart';



class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(categoryProvider);
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: state.when(
                data: (data){
                  return GridView.builder(
                     itemCount: data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        mainAxisSpacing: 5,
                        mainAxisExtent: 200,
                        crossAxisSpacing: 5
                      ),
                      itemBuilder: (context, index){
                       final cat = data[index];
                        return InkWell(
                          onTap: (){
                            Get.to(() => DetailPage(category: cat.strCategory));
                          },
                          child: Column(

                            children: [
                              Text(cat.strCategory),
                              CachedNetworkImage(
                                 placeholder: (c, s) => SpinKitSquareCircle(
                                   color: Colors.pink,
                                   size: 20.0,

                                 ),
                                 imageUrl: cat.strCategoryThumb),
                              Text(cat.strCategoryDescription,maxLines: 3, )
                            ],
                          ),
                        );
                      }
                  );
                },
                error: (err, stack) => Center(child: Text('$err')),
                loading: () => Center(child: CircularProgressIndicator())
            ),
          ),
        )
    );
  }
}
