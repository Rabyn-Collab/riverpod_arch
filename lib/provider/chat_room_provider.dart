import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutterspod/service/chat_rooms_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';




final roomStream = StreamProvider.autoDispose((ref) => FirebaseChatCore.instance.rooms());

final chatStream = StreamProvider.autoDispose.family((ref, types.Room room) => FirebaseChatCore.instance.messages(room));

final roomNotifier = AsyncNotifierProvider(() => RoomNotifier());

class RoomNotifier extends AsyncNotifier{

  @override
  FutureOr build() {

  }

  Future<void> createRoom({required types.User user}) async{
    state = const AsyncLoading();

    state = await AsyncValue.guard(() => RoomService.createRoom(user: user));
  }



}