import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/models/movie_state.dart';
import 'package:flutterspod/service/api_service.dart';


final emptyMovie = MovieState(
  isError: false,
  isLoad: false,
  errMessage: '',
  movies: [],
  page: 1,
);



final searchProvider =
StateNotifierProvider<SearchProvider, MovieState>((ref)
=> SearchProvider(emptyMovie,  service: ref.watch(apiService)));

class SearchProvider extends StateNotifier<MovieState>{
  final ApiService service;

  SearchProvider(super.state, {required this.service});

  Future<void>  getSearchMovie({required String query})async{
    state = state.copyWith(isLoad: true, isError: false);
    final response = await service.getSearchMovie(query: query);
    response.fold(
            (l) => state = state.copyWith(isError: true,isLoad: false, errMessage: l),
            (r) => state = state.copyWith(isError: false,isLoad: false,
            movies: [...state.movies, ...r]));
  }
  

}