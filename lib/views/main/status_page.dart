import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/provider/auth_provider.dart';
import 'package:flutterspod/views/auth/auth_page.dart';
import 'package:flutterspod/views/main/home_page.dart';



class StatusPage extends ConsumerWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(userStream);
    return state.when(data: (data){
       if(data == null){
         return AuthPage();
       }else{
         return HomePage();
       }
      },
        error: (err, st) => Center(child: Text('$err')),
        loading: () => Center(child: CircularProgressIndicator())
    );
  }
}
