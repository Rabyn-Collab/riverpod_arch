import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Sample extends StatelessWidget {
  const Sample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
             ListTile(
               leading: CircleAvatar(
                 radius: 30,
                 backgroundImage: NetworkImage('https://images.unsplash.com/photo-1695132823785-8fa0449cfaa3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxM3x8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60'),
               ),
               title: Text('By Author'),
               subtitle: Text('lorem ipsum da the u ni'),
               trailing: Icon(CupertinoIcons.chevron_forward),
             ),
              ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage('https://images.unsplash.com/photo-1695132823785-8fa0449cfaa3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxM3x8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60'),
                ),
                title: Text('By Author'),
                subtitle: Text('lorem ipsum da the u ni'),
                trailing: Icon(CupertinoIcons.chevron_forward),
              ),
              ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage('https://images.unsplash.com/photo-1695132823785-8fa0449cfaa3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxM3x8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60'),
                ),
                title: Text('By Author'),
                subtitle: Text('lorem ipsum da the u ni'),
                trailing: Icon(CupertinoIcons.chevron_forward),
              ),
            ],
          ),
        )
    );
  }
}
