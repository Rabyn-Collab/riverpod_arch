import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/constants/api.dart';
import 'package:flutterspod/exception/api_exception.dart';
import 'package:flutterspod/models/user.dart';
import 'package:flutterspod/shared/client_provider.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hive_flutter/hive_flutter.dart';



final authService = Provider((ref) => AuthService(ref.watch(clientProvider)));

class AuthService{

  final Dio dio;
  AuthService(this.dio);

   Future<Either<String, User>>  userLogin ({required Map<String, dynamic> data}) async{
    try{
      final response = await dio.post(Api.userLogin, data: data);
      final box  = Hive.box<String?>('userBox');
       box.put('user', jsonEncode(response.data));
      return Right(response.data);
    }on DioException catch (err){
      return Left(ApiError.errorCheck(err));
    }on HiveError catch(err){
      return Left(err.message);
    }
  }

}