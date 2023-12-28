import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/models/post.dart';
import 'package:flutterspod/provider/chat_room_provider.dart';
import 'package:flutterspod/provider/post_provider.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class DetailPage extends ConsumerWidget{
  final String postId;
  final types.User user;
  DetailPage({super.key, required this.postId, required this.user});
final commentC = TextEditingController();
  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(singlePostStream(postId));

    return Scaffold(
        body: state.when(
            data: (data){
              return ListView(
                children: [
                  Image.network(data.imageUrl),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: commentC,
                      onFieldSubmitted: (val){
                        if(val.isNotEmpty && val.length > 15){
                          ref.read(postNotifier.notifier).addComment(
                              postId: postId,
                              comments: [...data.comments, Comment(
                                  username: user.firstName!, comment: val.toString(), userImage: user.imageUrl!)]
                          );
                          commentC.clear();
                        }else{

                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'add a comment'
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                      itemCount: data.comments.length,
                      itemBuilder: (context, index){
                      final comment = data.comments[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(comment.userImage),
                          ),
                          title: Text(comment.username),
                          subtitle: Text(comment.comment),
                        );
                      }
                  )
                ],
              );
            },
            error: (err, st) => Center(child: Text('$err')),
            loading: () => Center(child: CircularProgressIndicator())
        )
    );
  }
}
