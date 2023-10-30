import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterspod/provider/api_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';



class DetailPage extends ConsumerWidget {
  final String category;
  const DetailPage({super.key, required this.category});

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(itemProvider(category));
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: state.when(
                data: (data){
                  return ListView.builder(
                      itemCount: data.length,

                      itemBuilder: (context, index){
                        return Column(

                          children: [
                            Text(data[index].strMeal),
                            Container(
                              height: 400,
                              child: CachedNetworkImage(
                                  placeholder: (c, s) => SpinKitSquareCircle(
                                    color: Colors.pink,
                                    size: 20.0,

                                  ),
                                  imageUrl: data[index].strMealThumb),
                            ),
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
