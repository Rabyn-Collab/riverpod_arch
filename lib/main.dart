import 'package:flutter/material.dart';
import 'package:flutterspod/constants/app_colors.dart';
import 'package:flutterspod/views/home_page.dart';




void main (){


runApp(Home());
}


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       theme: ThemeData.light(
         useMaterial3: true
       ).copyWith(
         scaffoldBackgroundColor: AppColors.mainColor,
         appBarTheme: AppBarTheme(
           backgroundColor:  AppColors.mainColor
         ),
       ),
      home: HomePage(),
    );
  }
}
