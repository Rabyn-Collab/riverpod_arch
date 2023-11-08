import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/models/movie.dart';
import 'package:flutterspod/provider/movie_provider.dart';
import 'package:flutterspod/views/detail_page.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:skeletonizer/skeletonizer.dart';


class TabBarWidget extends ConsumerWidget{
  final String pageKey;
  const TabBarWidget({super.key, required this.pageKey});

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(movieProvider(pageKey));
    if(state.isLoad){
      return Skeletonizer(child: _buildPadding(List.generate(10, (index) => Movie.empty()), ref));
    }else if(state.isError){
      return OfflineBuilder(
        connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          if(connected) ref.invalidate(movieProvider(pageKey));
          return Column(
            children: [
              Container(
                  height: 350,
                  child: Lottie.asset('assets/json/ani.json')),
              Center(child: Text(connected ? 'You Are Online' : state.errMessage)),
            ],
          );
        },
        child: Container(),
      );
    }else{
      return _buildPadding(state.movies, ref);
    }
  }

  Padding _buildPadding(List<Movie> movies, WidgetRef ref) {

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: NotificationListener(
        onNotification: (onNotification){
          if (onNotification is ScrollEndNotification) {
            final before = onNotification.metrics.extentBefore;
            final max = onNotification.metrics.maxScrollExtent;
            print(before);
            //print(max);
            if (before == max) {
             ref.read(movieProvider(pageKey).notifier).loadMore(pageKey);

            }
          }
          return false;
        },
        child: GridView.builder(
          key: PageStorageKey(pageKey),
          itemCount: movies.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              childAspectRatio: 3/4,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5
            ),
            itemBuilder: (context, index){
            final movie = movies[index];
            return InkWell(
                onTap: (){
                  Get.to(() => DetailPage(movie: movie));
                },
                child: CachedNetworkImage(imageUrl: movie.poster_path, fit: BoxFit.cover,));
            }
        ),
      ),
    );
  }
}
