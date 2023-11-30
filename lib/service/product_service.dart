import 'package:dio/dio.dart';

import 'package:flutterspod/constants/api.dart';
import 'package:flutterspod/exception/api_exception.dart';
import 'package:flutterspod/models/product.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';



class ProductService{

  final Dio auth_dio;
  final Dio dio;
  ProductService(this.auth_dio, this.dio);

  Future<List<Product>>  getProducts () async{
    try{
      final response = await auth_dio.get(Api.getProducts);
      return (response.data as List).map((e) => Product.fromJson(e)).toList();
    }on DioException catch (err){
      throw ApiError.errorCheck(err);
    }
  }


  Future<Either<String, bool>>  addProduct ({
   required Map<String, dynamic> data,required XFile image
    }) async{

    try{

      final formData = FormData.fromMap({
        for(final m in data.entries) m.key: m.value,
        'product_image': await MultipartFile.fromFile(image.path, filename: image.name),
      });
      // final formData = FormData.fromMap({
      //   'product_name': product_name,
      //   'product_detail': product_detail,
      //   'brand': brand,
      //   'category': category,
      //   'countInStock': countInStock,
      //   'product_price': product_price,
      //   'product_image': await MultipartFile.fromFile(product_image.path, filename: product_image.name),
      // });

      final response = await auth_dio.post(Api.addProduct, data: formData);
      return Right(true);
    }on DioException catch (err){
       return  Left(ApiError.errorCheck(err));
    }
  }







}