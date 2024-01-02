import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/firebase_options.dart';
import 'package:flutterspod/firebase_service.dart';
import 'package:flutterspod/views/main/status_page.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  await Firebase.initializeApp();


}

//somes codes
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  "high_importance_channel",
  "high_importance_channel",
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

const InitializationSettings initializationSettings =
InitializationSettings(
  android: AndroidInitializationSettings("@mipmap/ic_launcher"),
);

void main () async{


 WidgetsFlutterBinding.ensureInitialized();
 await Future.delayed(Duration(milliseconds: 500));

 await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
 );
 FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
 await flutterLocalNotificationsPlugin
     .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
     ?.createNotificationChannel(channel);
 flutterLocalNotificationsPlugin.initialize(
   initializationSettings,
 );
runApp(
    ProviderScope(

    child: Home()
));

}


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return ScreenUtilInit(
      designSize: Size(w, h),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (c, s) => GetMaterialApp(
        title: "It's On",
        debugShowCheckedModeBanner: false,
         theme: ThemeData.dark(
           useMaterial3: true
         ),
        home: StatusPage(),
      ),
    );
  }
}



class Counter extends StatelessWidget {

  int number = 0;
 final StreamController counts = StreamController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: StreamBuilder(
          stream: counts.stream,
          builder: (context, snapshot) {
               return Center(child: Text(snapshot.data.toString()));

          }
        ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            counts.sink.add(90);
          },
        child: Icon(Icons.add),
      ),
    );
  }
}
