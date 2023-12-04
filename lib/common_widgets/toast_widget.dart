

import 'package:flutter/material.dart';
import 'package:flutterspod/views/main/user_page/cart_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class Toasts{

  static  showSuccess({required String message}){
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.green,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 16.0,
    );
  }

  static  showCartSuccess({required String message, required BuildContext context}){
     ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
            showCloseIcon: true,
             action: SnackBarAction(label: 'GO To Cart', onPressed: (){
               Get.to(() => CartPage(), transition: Transition.leftToRight);
             }),
             duration: Duration(milliseconds: 1500),
             content: Text(message))
     );
  }

  static  showCartError({required String message, required BuildContext context}){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.pink,
            showCloseIcon: true,
            closeIconColor: Colors.white,
            action: SnackBarAction(
                textColor: Colors.white,
                label: 'GO To Cart', onPressed: (){
              Get.to(() => CartPage(), transition: Transition.leftToRight);
            }),
            duration: Duration(milliseconds: 1500),
            content: Text(message, style: TextStyle(color: Colors.white),))
    );
  }


  static  showError({required String message}){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.pink,
        fontSize: 16.0
    );
   }
}