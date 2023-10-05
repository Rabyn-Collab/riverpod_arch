import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterspod/constants/app_sizes.dart';
import 'package:flutterspod/constants/book_data.dart';



class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       title: Text('Hi John,'),
       actions: [
         Icon(Icons.search,),
         AppSizes.gapW12,
         Icon(CupertinoIcons.bell),
         AppSizes.gapW20
       ],
     ),
      body: ListView(

        children: [




          // Container(
          //   height: 250,
          //   width: 400,
          //   color: Colors.amber,
          //   child: Image.network(
          //     fit: BoxFit.cover,
          //     'https://images.unsplash.com/photo-1682686581556-a3f0ee0ed556?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxfHx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60',
          //   ),
          // ),

          Container(
            height: 250,
            width: 400,
            color: Colors.amber,
            child: Image.asset(
              'assets/images/book.jpg',
              fit: BoxFit.cover,
          )),

          AppSizes.gapH16,


          Container(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
                itemCount: books.length,
                itemBuilder: (context, index){
                final book = books[index];
                return Container(
                  width: 380,
                  margin: EdgeInsets.only(right: 10),
                  child: Stack(
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
                                       Text(book.detail, maxLines: 4,),
                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: [
                                           Text(book.rating),
                                           Text(book.genre)
                                         ],
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
                          child: 
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(book.imageUrl, height: 200,)))
                    ],
                  )
                );
                }
            ),
          ),
          // Row(
          //   children: [
          //   Expanded(child: Container(color: Colors.red, child: Text('aslkdj'),)),
          //   Expanded(child: Container(color: Colors.amber, child: Text('aslkdj'),)),
          //   ],
          // )


        ],
      )
    );
  }
}
