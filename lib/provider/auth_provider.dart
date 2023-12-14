import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/service/auth_service.dart';




final authProvider = AsyncNotifierProvider(() => AuthNotifier());

class AuthNotifier extends AsyncNotifier{

  @override
  FutureOr build() {

  }

  Future<void> userLogin({required Map<String, dynamic> data}) async {
   state = const AsyncLoading();
   state = await AsyncValue.guard(() =>
       AuthService.userLogin(data: data));
  }

}