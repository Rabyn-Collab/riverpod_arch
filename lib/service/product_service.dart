import 'package:dio/dio.dart';

import 'package:flutterspod/constants/api.dart';
import 'package:flutterspod/exception/api_exception.dart';
import 'package:flutterspod/models/product.dart';
import 'package:fpdart/fpdart.dart';



class ProductService{

  final Dio dio;
  ProductService(this.dio);

  Future<List<Product>>  getProducts () async{
    try{
      final response = await dio.get(Api.getProducts);
      return (response.data as List).map((e) => Product.fromJson(e)).toList();
    }on DioException catch (err){
      throw ApiError.errorCheck(err);
    }
  }


  Future<Either<String, bool>>  addProduct ({
   required String product_name,
    required String product_detail,
   required int product_price,
   required int product_image,
   required String  brand,
    required String category,
    required int countInStock,
    }) async{

    try{

      final formData = FormData.fromMap({
        'product_name': product_name,
        'product_detail': product_detail,
        'brand': brand,
        'category': category,
        'countInStock': countInStock,
        'product_price': product_price,
        'product_image': await MultipartFile.fromFile('./text.txt', filename: 'upload.txt'),
      });

      final response = await dio.post(Api.addProduct, data: product_image);
      return Right(true);
    }on DioException catch (err){
      throw ApiError.errorCheck(err);
    }
  }







}