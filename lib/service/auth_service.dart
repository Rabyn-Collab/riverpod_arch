import 'package:firebase_auth/firebase_auth.dart';
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
      final response = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseException catch (err) {
      throw err.message.toString();
    }
  }
}
