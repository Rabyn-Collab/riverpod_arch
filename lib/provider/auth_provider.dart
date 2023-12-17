import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/service/auth_service.dart';




final authProvider = AsyncNotifierProvider(() => AuthNotifier());

final userStream = StreamProvider((ref) => FirebaseAuth.instance.authStateChanges());


// Stream<String>  getData () async*{
//   yield 'asd;lkasd;l';
// }


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