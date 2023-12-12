import 'package:dio/dio.dart';
import 'package:flutterspod/provider/auth_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'client_provider.g.dart';


@Riverpod(keepAlive: true)
Dio client (ClientRef ref) => Dio(
  BaseOptions(),
);


@riverpod
Dio authClient (AuthClientRef ref) {
  final auth = ref.watch(authProvider);
  return Dio(
    BaseOptions(
      headers: {
        'Authorization': auth.user?.token
      }
    ),
  );
}