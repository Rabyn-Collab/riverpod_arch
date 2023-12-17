
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension OnAsync on AsyncValue{

  void showToasts(BuildContext context, String msg){
    if(this.hasError && !this.isLoading){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(msg)));
    }else if(!this.hasError && !this.isLoading){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(msg)));
    }
  }



}