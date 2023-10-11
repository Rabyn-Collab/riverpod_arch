import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final someData = Provider((ref) => 'Hello World');



final countProvider = ChangeNotifierProvider((ref) => CountsNotifier());



class  CountsNotifier  extends ChangeNotifier{

  int number = 0;


  void increment(){
    number++;
    notifyListeners();
  }


  void decrement(){
    number--;
    notifyListeners();
  }




}