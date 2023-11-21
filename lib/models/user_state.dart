





import 'package:flutterspod/models/user.dart';

class UserState{
  final String errMsg;
  final bool isSuccess;
  final bool isError;
  final bool isLoading;
  final User user;


  UserState({
    required this.user,
    required this.isLoading,
    required this.isSuccess,
    required this.isError,
    required this.errMsg
});



}