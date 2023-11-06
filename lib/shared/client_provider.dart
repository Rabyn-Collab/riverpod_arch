import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/constants/api.dart';


final clientProvider = Provider((ref) => Dio(
  BaseOptions(
     // headers: {
     //   'Authorization': Api.apiToken
     // },
      baseUrl: Api.baseUrl),
));