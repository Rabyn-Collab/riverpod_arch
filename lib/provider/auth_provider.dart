
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/main.dart';
import 'package:flutterspod/models/user_state.dart';
import 'package:flutterspod/service/auth_service.dart';
import 'package:flutterspod/views/auth/login_page.dart';
import 'package:get/get.dart';



final authProvider = StateNotifierProvider.autoDispose<AuthProvider, UserState>((ref) => AuthProvider(
    UserState(
      isSuccess: false,
      errMsg: '',
      isError: false,
      isLoading: false,
      user: ref.watch(boxA)
    ), ref.watch(authService)
));


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


  Future<void>  addressUpdate ({required Map<String, dynamic> data, required String token}) async{
    state = state.copyWith(isError: false, isSuccess: false, isLoading: true);
    final response = await service.addressUpdate(data: data, token: token);
    response.fold((l) {
      state = state.copyWith(isLoading: false, isError: true,isSuccess: false, errMsg: l);
    }, (r) {
      state = state.copyWith(isLoading: false, isError: false,isSuccess: true,user: r);
    });
  }


  Future<void>  userRegister ({required Map<String, dynamic> data}) async{
    state = state.copyWith(isError: false, isSuccess: false, isLoading: true);
    final response = await service.userRegister(data: data);
    response.fold((l) {
      state = state.copyWith(isLoading: false, isError: true,isSuccess: false, errMsg: l);
    }, (r) {
      state = state.copyWith(isLoading: false, isError: false,isSuccess: r);
    });
  }

  void  userLogOut () {
  final response = service.userLogOut();
     response.fold((l) {
     state = state.copyWith(isLoading: false, isError: true,isSuccess: false, errMsg: l);
    }, (r) {
       Get.offAll(() => LoginPage());
      state = state.copyWith(isLoading: false, isError: false,isSuccess: true,user: null);
    });
  }

}