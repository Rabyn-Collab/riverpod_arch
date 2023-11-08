import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/constants/api.dart';
import 'package:flutterspod/exception/api_exception.dart';
import 'package:flutterspod/models/movie.dart';
import 'package:flutterspod/models/video.dart';
import 'package:flutterspod/shared/client_provider.dart';




final apiService = Provider((ref) => ApiService(ref.watch(clientProvider)));

class ApiService {

  final Dio dio;
  ApiService(this.dio);


Future<Either<String, List<Movie>>> getMovieByCategory({required String apiPath, required int page})async{
  try{
    final response = await dio.get(apiPath,
    queryParameters: {
      'page': page
    },
    );
   return Right((response.data['results'] as List).map(
           (e) => Movie.fromJson(e)).toList());
  }on DioException catch(err){
    return Left(ApiError.errorCheck(err));
  }


}



  Future<Either<String, List<Movie>>> getSearchMovie({required String query})async{
    try{
      final response = await dio.get(Api.getSearchMovie,
        queryParameters: {
          'query': query
        },
      );
      final res = response.data['results'] as List;
      if(res.isEmpty){
        return Left('please search with valid keyword');
      }else{
        return Right(res.map(
                (e) => Movie.fromJson(e)).toList());
      }

    }on DioException catch(err){

      return Left(ApiError.errorCheck(err));
    }


  }



  Future<List<Video>> getMovieVideo({required int id})async{
    try{
      final response = await dio.get('/movie/${id}/videos');
      final res = response.data['results'] as List;
      if(res.isEmpty){
        throw 'there is no video available';
      }else{
        return res.map((e) => Video.fromJson(e)).toList();
      }

    }on DioException catch(err){
        throw Left(ApiError.errorCheck(err));
    }

  }





}
