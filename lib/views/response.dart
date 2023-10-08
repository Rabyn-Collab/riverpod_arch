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
        body: SafeArea(
          child: Column(
            children: [
           Container(
             height: 200,
             width: 400,
             color: Colors.green,
             child: LayoutBuilder(
                 builder: (context, contrs){
                   return Container(
                     color: Colors.black,
                     child: Text('asd;lk'),
                     width: contrs.maxWidth * 0.5,
                     height: contrs.maxHeight * 0.2,
                   );
                 }
             ),
           ),
            ],
          ),
        )
    );
  }
}
