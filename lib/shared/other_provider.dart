import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'other_provider.g.dart';


@riverpod
class Mode extends _$Mode {
  @override
  AutovalidateMode build() => AutovalidateMode.disabled;

  void change() => AutovalidateMode.onUserInteraction;

}


@riverpod
class Toggle extends _$Toggle {

  @override
  bool build() => false;


  void change() {
    state = !state;
  }

}
