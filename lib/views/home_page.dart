import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterspod/constants/app_sizes.dart';
import 'package:flutterspod/constants/book_data.dart';
import 'package:flutterspod/models/book.dart';
import 'package:flutterspod/views/DetailPage.js.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Hi John,'),
          actions: [
            Icon(
              Icons.search,
            ),
            AppSizes.gapW12,
            Icon(CupertinoIcons.bell),
            AppSizes.gapW20
          ],
        ),
        body: ListView(
          children: [
            Container(
                height: 250.h,
                width: 400.w,
                color: Colors.amber,
                child: Image.asset(
                  'assets/images/book.jpg',
                  fit: BoxFit.cover,
                )),
            AppSizes.gapH16,
            _buildContainer(width: 380.w, height: 250.h, isRateShow: true),
            Padding(
              padding:  EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              child: Text(
                'You may also like',
                style: TextStyle(fontSize: 25.sp),
              ),
            ),
            _buildContainer(width: 170.w, height: 220.h, isRateShow: false),
            AppSizes.gapH12,
          ],
        ));
  }

  Stack _buildStack(Book book) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 200.h,
            child: Card(
              color: Colors.orangeAccent,
              child: Row(
                children: [
                  Spacer(),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding:  EdgeInsets.only(left: 20.w, right: 10.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(book.title),
                          Text(
                            book.detail,
                            maxLines: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text(book.rating), Text(book.genre)],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
            left: 15,
            bottom: 20,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.network(
                  book.imageUrl,
                  width: 100.w,
                  height: 200.h,
                  fit: BoxFit.fill,
                )))
      ],
    );
  }

  Container _buildContainer(
      {required double height,
      required double width,
      required bool isRateShow}) {
    return Container(
      height: height,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: books.length,
          itemBuilder: (context, index) {
            final book = books[index];
            return Container(
              margin: EdgeInsets.only(right: 10.w),
              width: width,
              child: isRateShow ? InkWell(
                  onTap: (){
                    Get.to(() => DetailPage(book: book), transition: Transition.leftToRight);
                  },
                  child: _buildStack(book)) : _column(book),
            );
          }),
    );
  }

  Column _column(Book book) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          book.imageUrl,
          height: 150.h,
          width: 120.w,
          fit: BoxFit.cover,
        ),
        Text(book.title),
        Text(book.genre)
      ],
    );
  }

  Column _buildColumn({required String label, required IconData iconData}) {
    return Column(
      children: [Text(label), Icon(iconData)],
    );
  }
}
