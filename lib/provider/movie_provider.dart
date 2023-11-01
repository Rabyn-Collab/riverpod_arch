import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/constants/api.dart';
import 'package:flutterspod/models/movie_state.dart';
import 'package:flutterspod/service/api_service.dart';


final emptyMovie = MovieState(
    isError: false,
    isLoad: false,
    errMessage: '',
    movies: [],
  page: 1,
  apiPath: Api.getPopular
);

final movieProvider = StateNotifierProvider<MovieProvider, MovieState>((ref) => MovieProvider(emptyMovie, ref.watch(apiService)));

class MovieProvider extends StateNotifier<MovieState>{
  final ApiService service;
  MovieProvider(super.state, this.service){
    getMovieByCategory();
  }

  Future<void>  getMovieByCategory()async{
    state = state.copyWith(isLoad: true, isError: false);
    final response = await service.getMovieByCategory(apiPath: state.apiPath, page: state.page);
    response.fold(
            (l) => state = state.copyWith(isError: true,isLoad: false, errMessage: l),
            (r) => state = state.copyWith(isError: false,isLoad: false,movies: r));
  }


  void changeCategory(String apiPath){
    state = state.copyWith(apiPath: apiPath);
    getMovieByCategory();

  }


}