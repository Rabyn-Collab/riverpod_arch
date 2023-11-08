





class Movie{

  final String title;
  final String poster_path;
  final String overview;
  final int id;
  final String vote_average;
  final String backdrop_path;

  Movie({
    required this.title,
    required this.id,
    required this.backdrop_path,
    required this.overview,
    required this.poster_path,
    required this.vote_average
});

  factory Movie.fromJson(Map<String, dynamic> json){
    return Movie(
        title: json['title'] ?? '',
        id: json['id'],
        backdrop_path: 'https://image.tmdb.org/t/p/original${json['backdrop_path']}',
        overview: json['overview'],
        poster_path: 'https://image.tmdb.org/t/p/w500${json['poster_path']}',
        vote_average: '${json['vote_average']}'
    );
  }


  factory Movie.empty(){
    return Movie(
        title: 'aslkjdlksajdlaskjd',
        id: 9000,
        backdrop_path: 'https://images.unsplash.com/photo-1682688759350-050208b1211c?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxfHx8ZW58MHx8fHx8',
        overview: 'sjkdklassadbsa hjbsdsa jasbdn sajds kj',
        poster_path: 'https://images.unsplash.com/photo-1682688759350-050208b1211c?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxfHx8ZW58MHx8fHx8',
        vote_average: '9.5'
    );
  }


}