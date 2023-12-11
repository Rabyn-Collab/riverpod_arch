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

      final response = await auth_dio.post(Api.addProduct, data: formData);
      return Right(true);
    }on DioException catch (err){
       return  Left(ApiError.errorCheck(err));
    }
  }



  Future<Product>  getProductById ({
    required String id
  }) async{

    try{
      final response = await auth_dio.get('${Api.commonProduct}/$id');
      return  Product.fromJson(response.data);
    }on DioException catch (err){
      throw ApiError.errorCheck(err);
    }
  }



  Future<Either<String, bool>>  addReview ({
 required String comment,
 required double  rating,
 required String username,
    required String id
  }) async{

    try{
        final response = await auth_dio.patch('${Api.commonProduct}/$id', data: {
          "comment": "wow nice product",
          "rating": 5,
          "username": "Babyn Sharma"
        });

      return Right(true);
    }on DioException catch (err){
      print(err);
      return  Left(ApiError.errorCheck(err));
    }
  }




  Future<Either<String, bool>>  updateProduct ({
    required Map<String, dynamic> data,
    XFile? image,
    String? imagePath,
    required String id
  }) async{

    try{
       if(image == null){
         final response = await auth_dio.patch('${Api.upDateProduct}/$id', data: data);
       }else{
         final formData = FormData.fromMap({
           for(final m in data.entries) m.key: m.value,
           'product_image': await MultipartFile.fromFile(image.path, filename: image.name),
           'imagePath': imagePath
         });
         final response = await auth_dio.patch('${Api.upDateProduct}/$id', data: formData);
       }

      return Right(true);
    }on DioException catch (err){
      print(err);
      return  Left(ApiError.errorCheck(err));
    }
  }





  Future<Either<String, bool>>  removeProduct ({
    required String id
  }) async{
    try{
        final response = await auth_dio.delete('${Api.commonProduct}/$id');
      return Right(true);
    }on DioException catch (err){
      print(err);
      return  Left(ApiError.errorCheck(err));
    }
  }


}