import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/provider/chat_room_provider.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:image_picker/image_picker.dart';
class ChatPage extends ConsumerWidget {
  final types.Room room;
  final String token;
  const ChatPage({super.key, required this.room, required this.token});

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
                  showUserAvatars: true,
                  showUserNames: true,
                  onAttachmentPressed: () async{
                    await ImagePicker().pickImage(source: ImageSource.gallery).then((value) async{
                      final ref = FirebaseStorage.instance.ref().child('chatImage/${value!.name}');
                      await ref.putFile(File(value.path));
                      final  url = await ref.getDownloadURL();
                      final message = types.PartialImage(
                        name: value.name,
                        size: File(value.path).lengthSync(),
                        uri: url,
                      );
                      FirebaseChatCore.instance.sendMessage(message, room.id);
                    });
                  },
                  messages: data,
                  onSendPressed: (val){
                     FirebaseChatCore.instance.sendMessage(val, room.id);
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
