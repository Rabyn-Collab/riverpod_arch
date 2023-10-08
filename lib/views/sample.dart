import 'package:flutter/material.dart';

const data = [
  {
    'title': 'Avatar',
    'poster':
        'https://plus.unsplash.com/premium_photo-1661582611532-f3aa2cb5b370?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8bW92aWV8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60'
  },
  {
    'title': 'I Am Legend',
    'poster':
        'https://plus.unsplash.com/premium_photo-1663076010545-c01827be01dc?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8bW92aWV8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60'
  },
];

class Sample extends StatelessWidget {
  const Sample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          _buildListTile(
              pressed: (){
                print('hello 1');
              },
              image: data[0]['poster']!,title: data[0]['title']!),
          _buildListTile(
              pressed: (){
                print('hello 2');
              },
              image: data[1]['poster']!,title: data[1]['title']!),


        ],
      ),
    ));
  }

  ListTile _buildListTile({required String image,
    required String title, required VoidCallback pressed}) {
    return ListTile(
      onTap: pressed,
      leading: CircleAvatar(
        child: Image.network(image),
      ),
      title: Text(title),
    );
  }
}
