
import 'package:freezed_annotation/freezed_annotation.dart';


part 'crud_state.freezed.dart';

@freezed
class CrudState with _$CrudState{

  const factory CrudState({
    required bool isLoading,
    required bool isSuccess,
    required bool isError,
    required String errMsg
  }) = _UserState;

  factory CrudState.empty(){
    return CrudState(
        isLoading: false,
        isSuccess: false,
        isError: false,
        errMsg: ''
    );
  }



}