import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class UserDetail extends ConsumerWidget {
  final types.User user;
  const UserDetail({super.key, required this.user});

  @override
  Widget build(BuildContext context, ref) {
    return const Placeholder();
  }
}
