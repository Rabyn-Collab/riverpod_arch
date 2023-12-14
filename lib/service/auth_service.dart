// import 'dart:convert';
//
// import 'package:dio/dio.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutterspod/constants/api.dart';
// import 'package:flutterspod/exception/api_exception.dart';
// import 'package:flutterspod/models/user.dart';
// import 'package:flutterspod/shared/client_provider.dart';
// import 'package:fpdart/fpdart.dart';
// import 'package:hive_flutter/hive_flutter.dart';
//
//
//
// final authService = Provider((ref) => AuthService(ref.watch(clientProvider)));
//
// class AuthService{
//
//   final Dio dio;
//
//   AuthService(this.dio);
//
//    Future<Either<String, User>>  userLogin ({required Map<String, dynamic> data}) async{
//     try{
//       final response = await dio.post(Api.userLogin, data: data);
//       final box  = Hive.box('userBox');
//        box.put('user', jsonEncode(response.data));
//       return Right(User.fromJson(response.data));
//     }on DioException catch (err){
//       print(err);
//         return Left(ApiError.errorCheck(err));
//     }on HiveError catch(err){
//       return Left(err.message);
//     }
//   }
//
//
//   Future<Either<String, User>>  addressUpdate ({required Map<String, dynamic> data, required String token}) async{
//      final map = {
//        for(final m in data.entries) m.key: m.value,
//        'isEmpty': false
//      };
//     try{
//       final response = await dio.patch(Api.userUpdate, data: {
//         'shippingAddress': map
//       },
//       options:  Options(
//           headers: {
//             'Authorization': token
//           }
//       ),
//
//       );
//       final box  = Hive.box('userBox');
//       box.put('user', jsonEncode(response.data));
//       return Right(User.fromJson(response.data));
//     }on DioException catch (err){
//       print(err);
//       return Left(ApiError.errorCheck(err));
//     }on HiveError catch(err){
//       return Left(err.message);
//     }
//   }
//
//
//
//   Future<Either<String, bool>>  userRegister ({required Map<String, dynamic> data}) async{
//     try{
//       final response = await dio.post(Api.userRegister, data: data);
//
//       return Right(true);
//     }on DioException catch (err){
//       return Left(ApiError.errorCheck(err));
//     }
//   }
//
//   Either<String, bool>  userLogOut () {
//     try{
//       final box  = Hive.box('userBox');
//       box.delete('user');
//       return Right(true);
//     }on HiveError catch(err){
//       return Left(err.message);
//     }
//   }
//
//
// }