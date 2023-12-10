import 'package:flutterspod/main.dart';
import 'package:flutterspod/models/user_state.dart';
import 'package:flutterspod/service/auth_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'user_notifier.g.dart';

@riverpod
class UserNotifier extends _$UserNotifier {
  AuthService get _service => ref.watch(authService);

  @override
  UserState build() {
   print('err');
    return  UserState(
        isSuccess: false,
        errMsg: '',
        isError: false,
        isLoading: false,
        user: ref.watch(boxA)
    );
  }


  Future<void>  userLogin ({required Map<String, dynamic> data}) async{

    state = state.copyWith(isError: false, isSuccess: false, isLoading: true);
    final response = await _service.userLogin(data: data);
    response.fold((l) {
      state = state.copyWith(isLoading: false, isError: true,isSuccess: false, errMsg: l);
    }, (r) {
      state = state.copyWith(isLoading: false, isError: false,isSuccess: true,user: r);
    });
  }


  Future<void>  userRegister ({required Map<String, dynamic> data}) async{
    state = state.copyWith(isError: false, isSuccess: false, isLoading: true);
    final response = await _service.userRegister(data: data);
    response.fold((l) {
      state = state.copyWith(isLoading: false, isError: true,isSuccess: false, errMsg: l);
    }, (r) {
      state = state.copyWith(isLoading: false, isError: false,isSuccess: r);
    });
  }

}