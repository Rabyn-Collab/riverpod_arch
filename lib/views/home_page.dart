import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterspod/views/widgets/tab_bar_widget.dart';
import 'package:get/get.dart';



class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          flexibleSpace: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.ideographic,
              children: [
                Text('Movie Tmdb',style: context.textTheme.titleMedium,),
                IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.search))
              ],
            ),
          ),
          bottom: TabBar(
            // indicatorSize: TabBarIndicatorSize.tab,
            // indicator: BoxDecoration(
            //   color: Colors.pink,
            //   borderRadius: BorderRadius.circular(10),
            //   shape: BoxShape.rectangle,
            //
            // ),
              tabs: [
                Tab(
                  text: 'Popular',
                ),
                Tab(
                  text: 'Top Rated',
                ),
                Tab(
                  text: 'Upcoming',
                ),
              ]
          ),
        ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
              children: [
              TabBarWidget(),
              TabBarWidget(),
              TabBarWidget(),

                ])
      ),
    );
  }
}
