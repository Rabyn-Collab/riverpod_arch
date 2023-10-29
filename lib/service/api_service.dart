import 'package:dio/dio.dart';

import 'package:flutterspod/models/MealCata.dart';




class ApiService{

 static final dio  = Dio();
  static  Future<List<MealCata>> getMealData() async{
    try{
      final response = await dio.get(
          'https://www.themealdb.com/api/json/v1/1/categories.php');
      return  (response.data['categories'] as List).map((e) => MealCata.fromjson(e)).toList();
    }on DioException catch (err){
       throw err.message.toString();
    }
  }

  
  
}