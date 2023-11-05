import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/common_widgets/toast_widget.dart';
import 'package:flutterspod/constants/app_sizes.dart';
import 'package:flutterspod/provider/search_provider.dart';


class SearchPage extends ConsumerWidget {
   SearchPage({super.key});
 final searchController = TextEditingController();
  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(searchProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              AppSizes.gapH10,
              TextFormField(
                controller: searchController,
                autofocus: true,
                onFieldSubmitted: (val){
                  if(val.isEmpty){
                   Toasts.showError(message: 'please provide search text');
                  }else{
                    ref.read(searchProvider.notifier).getSearchMovie(query: val.trim());
                    searchController.clear();
                  }

                },
                decoration: InputDecoration(
                  hintText: 'search movies',
                  hintStyle: TextStyle(fontSize: 16)
                ),
              ),
              AppSizes.gapH10,
              state.isLoad ? Center(child: CircularProgressIndicator())
                  : state.isError ? Column(
                    children: [
                      AppSizes.gapH10,
                      Center(child: Text('${state.errMessage}')),
                    ],
                  ): Expanded(
                child: GridView.builder(
                    itemCount: state.movies.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 3/4,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5
                    ),
                    itemBuilder: (context, index){
                      final movie = state.movies[index];
                      return CachedNetworkImage(
                        errorWidget: (c, s, o){
                          return Image.network('https://images.unsplash.com/photo-1485846234645-a62644f84728?auto=format&fit=crop&q=60&w=600&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bW92aWV8ZW58MHx8MHx8fDA%3D');
                        },
                        imageUrl: movie.poster_path, fit: BoxFit.cover,);
                    }
                ),
              )

            ],
          ),
        )
    );
  }
}
