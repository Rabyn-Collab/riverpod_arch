

import 'package:dio/dio.dart';
import 'package:flutterspod/constants/api.dart';
import 'package:flutterspod/models/movie.dart';



class ApiService {

  final Dio dio;
  ApiService(this.dio);



Future<List<Movie>> getMovieByCategory({required String apiPath,required int page})async{

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

  }on DioException catch(err){
    throw '${err.response}';
  }


}





}
