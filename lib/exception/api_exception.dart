

import 'package:dio/dio.dart';

class ApiError  {

static  String errorCheck(DioException error){
    switch(error.type){
      case DioExceptionType.connectionTimeout:
        return "please check your connection";

      case DioExceptionType.sendTimeout:
        return "Send timed out";

      case DioExceptionType.receiveTimeout:
        return  "Receive timed out";

      case DioExceptionType.badCertificate:
        return  "Bad SSL certificates";

      case DioExceptionType.badResponse:

        switch(error.response!.statusCode){
           case 400:
          return  "Bad request";
          case 401:
            return  "Permission denied";

          case 404:
            return  "Page not Found";

          case 405:
            return  "Method not Allowed";

          case 422:
            return  "Too many request";

          case 500:
            return  "Server internal error";

          default:
            return  error.response.toString();

        }

      case DioExceptionType.connectionError:
        return  "Connection error";

      case DioExceptionType.unknown:
        return "please check your connection";

      default:
        return 'something went wrong';
    }
  }


}