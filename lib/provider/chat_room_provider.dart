import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutterspod/service/chat_rooms_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';




final roomStream = StreamProvider.autoDispose((ref) => FirebaseChatCore.instance.rooms());

final chatStream = StreamProvider.autoDispose.family((ref, types.Room room) => FirebaseChatCore.instance.messages(room));

final roomNotifier = AsyncNotifierProvider(() => RoomNotifier());


final  singleRoomStream = StreamProvider.family((ref, String id) {
  final snapshots = FirebaseFirestore.instance.collection('rooms').where('userIds', arrayContains: id).snapshots();
  return snapshots.map((event) => event);

});



class RoomNotifier extends AsyncNotifier{

  @override
  FutureOr build() {

  }

  Future<void> createRoom({required types.User user}) async{
    state = const AsyncLoading();

    state = await AsyncValue.guard(() => RoomService.createRoom(user: user));
  }



}