import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/service/post_service.dart';
import 'package:image_picker/image_picker.dart';




final postNotifier = AsyncNotifierProvider(() => PostNotifier());


class PostNotifier extends AsyncNotifier{

  @override
  FutureOr build() {

  }


  Future<void> createPost(
      {required String title,
        required String detail,
        required String userId,
        required XFile image}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() =>
        PostService.createPost(title: title, detail: detail, userId: userId, image: image));
  }


  Future<void> removePost(
      {
        required String imageId,
        required String postId}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() =>
        PostService.removePost(imageId: imageId, postId: postId));
  }

}