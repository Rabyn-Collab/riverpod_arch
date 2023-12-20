import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/models/post.dart';
import 'package:flutterspod/service/post_service.dart';
import 'package:image_picker/image_picker.dart';




final postNotifier = AsyncNotifierProvider(() => PostNotifier());


final postsStream = StreamProvider((ref) {
    final snapshots = FirebaseFirestore.instance.collection('posts').snapshots();
  return snapshots.map((event) => event.docs.map((e) {
    final json = e.data();
    return Post(
        comments: (json['comments'] as List).map((e) => Comment.fromJson(e)).toList(),
        imageUrl: json['imageUrl'],
        id: e.id,
        title: e['title'],
        detail: e['detail'],
        imageId: e['imageId'],
        userId: e['userId'],
      like: Like.fromJson(json['like'])
    );
  }).toList());
});




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