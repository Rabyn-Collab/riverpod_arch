import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/constants/api.dart';
import 'package:flutterspod/models/movie.dart';
import 'package:flutterspod/shared/client_provider.dart';




final apiService = Provider((ref) => ApiService(ref.watch(clientProvider)));

class ApiService {

  final Dio dio;
  ApiService(this.dio);


Future<Either<String, List<Movie>>> getMovieByCategory({required String apiPath,required int page})async{
  try{

    final response = await dio.get('Api.baseUrl/$apiPath',
    queryParameters: {
      'page': page
    },
    options: Options(
      headers: {
        'Authorization': Api.apiToken
      }
    )
    );
   return Right((response.data['results'] as List).map(
           (e) => Movie.fromJson(e)).toList());
  }on DioException catch(err){
    return Left('${err.response}');
  }


}





}
