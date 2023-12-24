import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/firebase_options.dart';
import 'package:flutterspod/views/main/status_page.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



void main () async{


 WidgetsFlutterBinding.ensureInitialized();
 await Future.delayed(Duration(milliseconds: 500));

 await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
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
