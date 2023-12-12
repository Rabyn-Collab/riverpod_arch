import 'package:dio/dio.dart';
import 'package:flutterspod/constants/api.dart';
import 'package:flutterspod/exception/api_exception.dart';
import 'package:flutterspod/models/order_item.dart';
import 'package:fpdart/fpdart.dart';



class OrderService{

  final Dio auth_dio;

  OrderService(this.auth_dio);

  Future<List<OrderItem>>  getAllOrders () async{
    try{
      final response = await auth_dio.get(Api.getAllOrders);
      return (response.data as List).map((e) => OrderItem.fromJson(e)).toList();
    }on DioException catch (err){
      throw ApiError.errorCheck(err);
    }
  }


  Future<Either<String, bool>>  addOrder ({
   required List<Map<String, dynamic>> orderItems,
   required int totalPrice,
  }) async{

    try{
      final response = await auth_dio.post(Api.addOrder, data: {
        'orderItems': orderItems,
        'totalPrice': totalPrice
      });
      return Right(true);
    }on DioException catch (err){
      return  Left(ApiError.errorCheck(err));
    }
  }




  Future<List<OrderItem>>  getOrderUser () async{

    try{
      final response = await auth_dio.get(Api.orderByUser);
      return (response.data as List).map((e) => OrderItem.fromJson(e)).toList();
    }on DioException catch (err){
      throw ApiError.errorCheck(err);
    }
  }






}