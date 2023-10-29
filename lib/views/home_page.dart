import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterspod/provider/api_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';



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
                        return Column(

                          children: [
                            Text(data[index].strCategory),
                            CachedNetworkImage(
                               placeholder: (c, s) => SpinKitSquareCircle(
                                 color: Colors.pink,
                                 size: 20.0,

                               ),
                               imageUrl: data[index].strCategoryThumb),
                            Text(data[index].strCategoryDescription,maxLines: 3, )
                          ],
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
