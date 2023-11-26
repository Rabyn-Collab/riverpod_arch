
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/main.dart';
import 'package:flutterspod/models/user_state.dart';
import 'package:flutterspod/service/auth_service.dart';



final authProvider = StateNotifierProvider<AuthProvider, UserState>((ref) => AuthProvider(
    UserState(
      isSuccess: false,
      errMsg: '',
      isError: false,
      isLoading: false,
      user: ref.watch(boxA)
    ), ref.watch(authService)));


class AuthProvider extends StateNotifier<UserState>{
  final AuthService service;
  AuthProvider(super.state, this.service);



  Future<void>  userLogin ({required Map<String, dynamic> data}) async{
      state = state.copyWith(isError: false, isSuccess: false, isLoading: true);
      final response = await service.userLogin(data: data);
      response.fold((l) {
        state = state.copyWith(isLoading: false, isError: true,isSuccess: false, errMsg: l);
      }, (r) {
        state = state.copyWith(isLoading: false, isError: false,isSuccess: true,user: r);
      });
  }

  void  userLogOut () {
  final response = service.userLogOut();
     response.fold((l) {
     state = state.copyWith(isLoading: false, isError: true,isSuccess: false, errMsg: l);
    }, (r) {
      state = state.copyWith(isLoading: false, isError: false,isSuccess: true,user: null);
    });
  }

}