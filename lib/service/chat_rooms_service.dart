import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';






class RoomService {

  static Future<types.Room> createRoom({required types.User user}) async{
       try{
         final response = await FirebaseChatCore.instance.createRoom(user);
         return response;
       }on FirebaseException catch(err){
           throw '${err.message}';
       }
  }

}