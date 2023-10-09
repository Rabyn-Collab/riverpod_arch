import 'package:flutter/material.dart';



class ResponsePage extends StatelessWidget {
  const ResponsePage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height
        - MediaQuery.of(context).padding.top - kToolbarHeight;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
        body: Column(
          children: [
           AspectRatio(
             aspectRatio: 4/3,
             child: Image.network(
                 'https://images.unsplash.com/photo-1696587522095-1d0b522b3e36?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0fHx8ZW58MHx8fHx8&auto=format&fit=crop&w=500&q=60',
               fit: BoxFit.cover,
             ),
           ),


        //     Container(
        //       color: Colors.amber,
        //       height: 100,
        //       width: 100,
        //       child: Text(
        //           'sal;dk;asldkslsdklfjlsdkfjldskfjlkdsfjlkdsjflkdsfjlkdsfjksdfljsdkjflkdsfjlkfdjdfksj', maxLines: 3,),
        //     ),
        //
        //
        //     Container(
        //         height: 100,
        // color: Colors.red,
        //         child: FittedBox(
        //             child: Text('as;dlk;saskjdklasdjlksadj askjdkjasdhsakjdhkjsadh',style: TextStyle(fontSize: 70),))),
        //
        //     Container(
        //       height: 200,
        //       width: width * 0.5,
        //       padding: EdgeInsets.only(bottom: 10),
        //       color: Colors.green,
        //       child: LayoutBuilder(
        //           builder: (context, contrs){
        //             return Row(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 Container(
        //                   height: contrs.maxHeight ,
        //                  width: 100,
        //                  color: Colors.red,
        //                 ),
        //               ],
        //             );
        //           }
        //       ),
        //     ),
          ],
        )
    );
  }
}
