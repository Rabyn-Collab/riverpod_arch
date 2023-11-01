
import 'package:flutterspod/models/movie.dart';

class MovieState{
  final bool isLoad;
  final bool isError;
  final String errMessage;
  final List<Movie> movies;
  final int page;
  final String apiPath;

  MovieState({
    required this.isError,
    required this.isLoad,
    required this.errMessage,
    required this.movies,
    required this.page,
    required this.apiPath
});

 MovieState copyWith({
    bool? isLoad,
    bool? isError,
   String? errMessage,
   List<Movie>? movies,
   int? page,
   String? apiPath
  }){
   return MovieState(
       isError: isError ?? this.isError,
       isLoad: isLoad ?? this.isLoad,
       errMessage: errMessage ?? this.errMessage,
       movies: movies ?? this.movies,
      page: page ?? this.page,
     apiPath: apiPath ?? this.apiPath
   );
 }

 @override
  String toString() {

    return 'MovieState('
       'isError: ${isError}, '
        'isLoad: ${isLoad}, '
        'errMessage: ${errMessage}, '
        'movies: ${movies}, '
        'apiPath: ${apiPath}, '
       ')';
  }


}