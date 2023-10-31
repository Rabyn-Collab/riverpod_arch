import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/models/movie_state.dart';
import 'package:flutterspod/service/api_service.dart';



final movieProvider = StateNotifierProvider<MovieProvider, MovieState>(
        (ref) => MovieProvider(
             MovieState(
                isError: false,
                isLoad: false,
                errMessage: '',
                movies: []
            ),
          ref.watch(apiService)
        )
);


class MovieProvider extends StateNotifier<MovieState>{
  final ApiService service;
  MovieProvider(super.state, this.service);

  Future<void>
  getMovieByCategory({required String apiPath,required int page})async{
    state = state.copyWith(isLoad: true, isError: false);
    final response = await service.getMovieByCategory(
        apiPath: apiPath, page: page);

    response.fold(
            (l) => state = state.copyWith(isError: true,isLoad: false, errMessage: l),
            (r) => state = state.copyWith(isError: false,isLoad: false,movies: r));
  }




}