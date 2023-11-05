import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/models/movie.dart';
import 'package:flutterspod/provider/video_provider.dart';
import 'package:flutterspod/views/widgets/video_widget.dart';




class DetailPage extends StatelessWidget {
  final Movie movie;
  const DetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
              child: ListView(
                children: [
                  Consumer(
                    builder: (context, ref, child) {
                      final state = ref.watch(videoProvider(movie.id));
                      return state.when(data: (data){
                        return PlayVideoFromNetwork(keyString: data[0].key);
                      }, error:(err, _) => Center(child: Text('$err')),
                          loading: () => Center(child: Container()));
                    }
                  ),
                ],
              )
          ),
        )
    );
  }
}
