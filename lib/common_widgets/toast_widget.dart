

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toasts{

  static  showSuccess({required String message}){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 16.0
    );
  }

  static  showError({required String message}){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.pink,
        fontSize: 16.0
    );
   }
}