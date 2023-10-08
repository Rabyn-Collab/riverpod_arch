import 'package:flutter/material.dart';
import 'package:flutterspod/constants/app_sizes.dart';
import 'package:flutterspod/models/book.dart';



class DetailPage extends StatelessWidget {
final Book book;
  const DetailPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      //   extendBody: true,
        body: Column(
          children: [
            Image.network(book.imageUrl,
              fit: BoxFit.cover,
              height: 400, width: double.infinity,),
            Text(book.title),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    minimumSize: Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                    onPressed: (){},
                    child: Text('Read Book')),
                AppSizes.gapW14,
                OutlinedButton(
                    onPressed: (){},
                    child: Text('Read Book')),
              ],
            )
          ],
        )
    );
  }
}
