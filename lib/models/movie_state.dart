
import 'package:flutterspod/models/movie.dart';

class MovieState{
  final bool isLoad;
  final bool isError;
  final String errMessage;
  final List<Movie> movies;

  MovieState({
    required this.isError,
    required this.isLoad,
    required this.errMessage,
    required this.movies
});

 MovieState copyWith({
    bool? isLoad,
    bool? isError,
   String? errMessage,
   List<Movie>? movies,
  }){
   return MovieState(
       isError: isError ?? this.isError,
       isLoad: isLoad ?? this.isLoad,
       errMessage: errMessage ?? this.errMessage,
       movies: movies ?? this.movies
   );
 }

}