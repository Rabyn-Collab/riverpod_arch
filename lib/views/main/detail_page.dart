import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/provider/post_provider.dart';

class DetailPage extends ConsumerWidget{
  final String postId;
  const DetailPage({super.key, required this.postId});

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(singlePostStream(postId));
    return Scaffold(
        body: state.when(
            data: (data){
              return ListView(
                children: [
                  Image.network(data.imageUrl)
                ],
              );
            },
            error: (err, st) => Center(child: Text('$err')),
            loading: () => Center(child: CircularProgressIndicator())
        )
    );
  }
}
