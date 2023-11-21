
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/service/auth_service.dart';

class AuthProvider extends StateNotifier{
  final AuthService service;
  AuthProvider(super.state, this.service);



  Future<void>  userLogin ({required Map<String, dynamic> data}) async{
      final response = await service.userLogin(data: data);
  }


}