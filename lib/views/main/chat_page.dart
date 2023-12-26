import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/provider/chat_room_provider.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
class ChatPage extends ConsumerWidget {
  final types.Room room;
  const ChatPage({super.key, required this.room});

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(chatStream(room));
    return Scaffold(
        body: SafeArea(
            child: state.when(
              error: (err, st) => Text('$err'),
              loading: () => CircularProgressIndicator(),
              data: (data){
                return Chat(
                  messages: data,

                  onSendPressed: (val){

                  },
                  user: types.User(
                    id: FirebaseAuth.instance.currentUser!.uid
                  ),

                );
              }
            )
        )
    );
  }
}
