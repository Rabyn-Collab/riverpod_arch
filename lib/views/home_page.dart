import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/provider/api_provider.dart';



class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Consumer(
              builder: (context, ref, child) {
                final state = ref.watch(apiProvider);
                return state.when(
                    data: (data){
                      return Text('$data');
                    },
                    error: (err, stack) => Text('$err'),
                    loading: () => Center(child: CircularProgressIndicator())
                );
              }
          ),
        )
    );
  }
}
