import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/provider/movie_provider.dart';
import 'package:flutterspod/views/detail_page.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';


class TabBarWidget extends ConsumerWidget{
  final String pageKey;
  const TabBarWidget({super.key, required this.pageKey});

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(movieProvider(pageKey));
    if(state.isLoad){
      return Center(child: CircularProgressIndicator());
    }else if(state.isError){
      return Column(
        children: [
          Lottie.asset('assets/json/ani.json'),
          Center(child: Text(state.errMessage)),
        ],
      );
    }else{
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: GridView.builder(
          key: PageStorageKey(pageKey),
          itemCount: state.movies.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              childAspectRatio: 3/4,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5
            ),
            itemBuilder: (context, index){
            final movie = state.movies[index];
            return InkWell(
                onTap: (){
                  Get.to(() => DetailPage(movie: movie));
                },
                child: CachedNetworkImage(imageUrl: movie.poster_path, fit: BoxFit.cover,));
            }
        ),
      );
    }
  }
}
