import 'package:dio/dio.dart';

import 'package:flutterspod/constants/api.dart';
import 'package:flutterspod/exception/api_exception.dart';
import 'package:flutterspod/models/product.dart';



class ProductService{

  final Dio dio;
  ProductService(this.dio);

  Future<List<Product>>  getProducts () async{
    try{
      final response = await dio.get(Api.getProducts);
      return [];
    }on DioException catch (err){
      throw ApiError.errorCheck(err);
    }
  }





}