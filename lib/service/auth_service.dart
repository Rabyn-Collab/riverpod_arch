import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/exception/api_exception.dart';
import 'package:flutterspod/shared/client_provider.dart';



final authService = Provider((ref) => AuthService(ref.watch(clientProvider)));

class AuthService{

  final Dio dio;
  AuthService(this.dio);

   Future<Either<String, bool>>  userLogin ({required Map<String, dynamic> data}) async{
    try{
      final response = await dio.post('', data: data);
      return Right(true);
    }on DioException catch (err){
      return Left(ApiError.errorCheck(err));
    }
  }

}