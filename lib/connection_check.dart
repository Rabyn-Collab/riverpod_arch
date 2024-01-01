
import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


enum ConnectivityStatus{
  ON,
  OFF,
  CHECK
}


final connectionProvider = StateNotifierProvider<ConnectivityProvider, ConnectivityStatus>((ref) => ConnectivityProvider(ref));
class ConnectivityProvider extends StateNotifier<ConnectivityStatus>{

  ConnectivityStatus? connectivityStatus;
  StreamController<ConnectivityResult> status = StreamController<ConnectivityResult>();
  StateNotifierProviderRef ref;
  ConnectivityProvider(this.ref) : super(ConnectivityStatus.CHECK) {
    connectivityStatus = ConnectivityStatus.CHECK;
    Connectivity().checkConnectivity().then((value) {
      if(value==ConnectivityResult.none){
        state = ConnectivityStatus.OFF;
      }
    });
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
      status.add(result);
      if (result == ConnectivityResult.none) {
        await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
          'status': 'offline'
        });
        state = ConnectivityStatus.OFF;
      } else {
        await _updateConnectionStatus().then((ConnectivityStatus isConnected) {
          state = isConnected;
        });
      }

    });
  }

  Future<ConnectivityStatus> _updateConnectionStatus() async {
    ConnectivityStatus connectivityStatus;
    try {
      final List<InternetAddress> result =
      await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
          'status': 'online'
        });
        connectivityStatus = ConnectivityStatus.ON;
      }else{

        connectivityStatus =  ConnectivityStatus.OFF;
      }
    } on SocketException catch (_) {
      await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
        'lastName': 'offline'
      });
      connectivityStatus =  ConnectivityStatus.OFF;
    }
    return connectivityStatus;
  }
}