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
);



final movieProvider =
StateNotifierProvider.family<MovieProvider, MovieState, String>((ref, String api)
=> MovieProvider(emptyMovie, api: api, service: ref.watch(apiService)));

class MovieProvider extends StateNotifier<MovieState>{
  final ApiService service;
  final String api;
  MovieProvider(super.state, {required this.api, required this.service}){
    getMovieByCategory(api);
  }

  Future<void>  getMovieByCategory(String apiPath)async{
    state = state.copyWith(isLoad: true, isError: false);
    final response = await service.getMovieByCategory(apiPath: apiPath, page: state.page);
    response.fold(
            (l) => state = state.copyWith(isError: true,isLoad: false, errMessage: l),
            (r) => state = state.copyWith(isError: false,isLoad: false,
                movies: [...state.movies, ...r]));
  }

  Future<void>  loadMore(String apiPath)async{
    state = state.copyWith(page: state.page + 1);
    getMovieByCategory(apiPath);
  }





}