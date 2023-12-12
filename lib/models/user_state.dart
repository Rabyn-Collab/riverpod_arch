
import 'package:flutterspod/models/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'user_state.freezed.dart';

@freezed
class UserState with _$UserState{

 const factory UserState({
    User?  user,
    required bool isLoading,
    required bool isSuccess,
    required bool isError,
    required String errMsg
}) = _UserState;

  factory UserState.empty(){
    return UserState(
        user: null,
        isLoading: false,
        isSuccess: false,
        isError: false,
        errMsg: ''
    );
  }



}