import 'dart:io';
import 'package:dio/dio.dart';
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
  final types.User user;
  final String currentUser;
  const ChatPage({super.key, required this.room, required this.user, required this.currentUser});

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
                  onSendPressed: (val) async{
                     FirebaseChatCore.instance.sendMessage(val, room.id);
                     final dio = Dio();
                     try{

                       final response  = await dio.post('https://fcm.googleapis.com/fcm/send',
                           options: Options(
                             headers: {
                               'Authorization': 'key=AAAAMx9eYIM:APA91bFKYWRg3zHUWacpFKJsjNbOInmGs-u3TeEHNnADh68xBJATj28MNKxyZCt5NkALnAuJDXcBb2d6gSqJ5xpe4Wq8nhFHGbaj-oFE-PvOOvy9TWPS0zOlW_e9Hd-05LQH9fD60-kX'
                             }
                           ),
                           data: {
                         "to" : user.metadata!['token'],
                         "priority": "High",
                         "android_channel_id": "high_importance_channel",
                         "notification":{
                           "body": val.text,
                           "title": currentUser
                         }

                       });

                     }on DioException catch(err){

                     }
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
