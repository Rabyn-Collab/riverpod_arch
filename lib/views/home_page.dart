import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                height: 250,
                width: 400,
                color: Colors.amber,
                child: Image.asset(
                  'assets/images/book.jpg',
                  fit: BoxFit.cover,
                )),
            AppSizes.gapH16,
            _buildContainer(width: 380, height: 250, isRateShow: true),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Text(
                'You may also like',
                style: TextStyle(fontSize: 25),
              ),
            ),
            _buildContainer(width: 170, height: 220, isRateShow: false),
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
            height: 200,
            child: Card(
              color: Colors.orangeAccent,
              child: Row(
                children: [
                  Spacer(),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 10),
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
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  book.imageUrl,
                  height: 200,
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
              margin: EdgeInsets.only(right: 10),
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
          height: 150,
          width: 120,
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
