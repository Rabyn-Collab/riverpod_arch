
import 'package:flutterspod/models/movie.dart';

class MovieState{
  final bool isLoad;
  final bool isError;
  final String errMessage;
  final List<Movie> movies;
  final int page;
  final bool isLoadMore;

  MovieState({
    required this.isError,
    required this.isLoad,
    required this.errMessage,
    required this.movies,
    required this.page,
    required this.isLoadMore
});

 MovieState copyWith({
    bool? isLoad,
    bool? isError,
   String? errMessage,
   List<Movie>? movies,
   int? page,
    bool? isLoadMore
  }){
   return MovieState(
       isError: isError ?? this.isError,
       isLoad: isLoad ?? this.isLoad,
       errMessage: errMessage ?? this.errMessage,
       movies: movies ?? this.movies,
      page: page ?? this.page,
     isLoadMore: isLoadMore ?? this.isLoadMore
   );
 }

 @override
  String toString() {

    return 'MovieState('
       'isError: ${isError}, '
        'isLoad: ${isLoad}, '
        'errMessage: ${errMessage}, '
        'movies: ${movies}, '
       ')';
  }


}