
import 'package:flutterspod/models/movie.dart';

class MovieState{
  final bool isLoad;
  final bool isError;
  final String errMessage;
  final List<Movie> movies;
  final int page;

  MovieState({
    required this.isError,
    required this.isLoad,
    required this.errMessage,
    required this.movies,
    required this.page,
});

 MovieState copyWith({
    bool? isLoad,
    bool? isError,
   String? errMessage,
   List<Movie>? movies,
   int? page,
  }){
   return MovieState(
       isError: isError ?? this.isError,
       isLoad: isLoad ?? this.isLoad,
       errMessage: errMessage ?? this.errMessage,
       movies: movies ?? this.movies,
      page: page ?? this.page,
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