import 'dart:io';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AuthService {

  static final _auth = FirebaseAuth.instance;


  static Future<void> userLogin({required Map<String, dynamic> data}) async {
    try {
      final response = await _auth.signInWithEmailAndPassword(
          email: data['email'], password: data['password']);
    } on FirebaseAuthException catch (err) {
      throw err.message.toString();
    }
  }



  static Future<bool> userRegister({
    required String email,
    required String password,
    required String username,
    required XFile image
  }) async {
    try {

      final ref = FirebaseStorage.instance.ref().child('userImage/${image.name}');
      await ref.putFile(File(image.path));
      final response = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final  url = await ref.getDownloadURL();
      await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
          firstName: username,
          id: response.user!.uid,
          imageUrl: url,
          lastName: 'chatter',
        ),
      );

      return true;
    } on FirebaseException catch (err) {
      print(err);
      throw err.message.toString();
    }
  }
}
