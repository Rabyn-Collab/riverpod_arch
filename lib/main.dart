import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterspod/views/auth/login_page.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';




void main () async{


 WidgetsFlutterBinding.ensureInitialized();
 await Future.delayed(Duration(milliseconds: 500));

 await Hive.initFlutter();
 final userBox = await Hive.openBox<String?>('userBox');

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
        debugShowCheckedModeBanner: false,
         theme: ThemeData.dark(
           useMaterial3: true
         ).copyWith(

           appBarTheme: AppBarTheme(

           ),
           textTheme: TextTheme(
             titleMedium: TextStyle(
               fontSize: 30,
               fontWeight: FontWeight.w500
             )
           )
         ),
      home: LoginPage(),
      ),
    );
  }
}
