
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../models/post.dart';

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
        'userId': userId,
        'like': {
          'likes': 0,
          'usernames': []
        },
        'comments': []
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



  static Future<bool> updatePost(
      {required String title,
        required String detail,
        String? imageId,
        required String postId,
        XFile? image}) async {
    try {
      if(image == null){
        await _db.doc(postId).update({
          'title': title,
          'detail': detail,
        });
      }else{
        final ref = FirebaseStorage.instance.ref().child('postImage/$imageId');
        await ref.delete();
        final newId = DateTime.now().toString();
        final ref1 = FirebaseStorage.instance.ref().child('postImage/$newId');
        await ref1.putFile(File(image.path));
        final url = await ref1.getDownloadURL();
        await _db.doc(postId).update({
          'title': title,
          'detail': detail,
          'imageUrl': url,
          'imageId': newId,
        });

      }

      return true;
    } on FirebaseException catch (err) {
      throw err.message.toString();
    }
  }



  static Future<bool> addComment(
      {required String postId,
        required Comment comment}) async {
    try {

        await _db.doc(postId).update({
          'comments': FieldValue.arrayUnion([comment]),
        });

      return true;
    } on FirebaseException catch (err) {
      throw err.message.toString();
    }
  }


  static Future<bool> addLike(
      {
        required String postId,
        required String username,
        required int like}) async {
    try {

        await _db.doc(postId).update({
          'like': {
            'likes': like + 1,
            'usernames': FieldValue.arrayUnion([username])
          },
        });



      return true;
    } on FirebaseException catch (err) {
      throw err.message.toString();
    }
  }



}
