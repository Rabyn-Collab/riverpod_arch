import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/provider/auth_provider.dart';
import 'package:flutterspod/views/auth/login_page.dart';
import 'package:flutterspod/views/main/home_page.dart';




class StatusPage extends ConsumerWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
       final authState = ref.watch(authProvider);
          return authState.user == null ? LoginPage(): HomePage();

  }
}
