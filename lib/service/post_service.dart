import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class PostService {
  static final _db = FirebaseFirestore.instance.collection('posts');

  static Future<bool> createPost(
      {required String title,
      required String detail,
      required String userId,
      required XFile image}) async {
    try {
      final imageId = DateTime.now().toString();
      final ref = FirebaseStorage.instance.ref().child('postImage/$imageId');
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      await _db.add({
        'title': title,
        'detail': detail,
        'imageUrl': url,
        'imageId': imageId,
        'userId': userId
      });
      return true;
    } on FirebaseException catch (err) {
      throw err.message.toString();
    }
  }

  static Future<bool> removePost(
      {
        required String imageId,
        required String postId}) async {
    try {
      final ref = FirebaseStorage.instance.ref().child('postImage/$imageId');
      await ref.delete();
      await _db.doc(postId).delete();
      return true;
    } on FirebaseException catch (err) {
      throw err.message.toString();
    }
  }

}
