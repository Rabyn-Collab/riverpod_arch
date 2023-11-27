import 'package:flutter/material.dart';
import 'package:flutterspod/provider/product_provider.dart';
import 'package:flutterspod/service/product_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'other_provider.g.dart';


@riverpod
class Mode extends _$Mode {
  @override
  AutovalidateMode build() => AutovalidateMode.disabled;

  void change() => state =  AutovalidateMode.onUserInteraction;

}


@riverpod
class Toggle extends _$Toggle {

  ProductService  get produtS => ref.read(productServiceProvider);
  @override
  bool build() => false;


  void change() {
    produtS.getProducts();
    state = !state;
  }




}
