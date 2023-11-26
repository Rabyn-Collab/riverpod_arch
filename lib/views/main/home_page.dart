import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/provider/auth_provider.dart';


class HomePage extends ConsumerWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page'),),
        drawer: Drawer(
          child: ListView(
            children: [
               ListTile(
                 onTap: (){
                   ref.read(authProvider.notifier).userLogOut();
                 },
                 leading: Icon(Icons.exit_to_app),
                 title: Text('userLogOut'),
               ),
            ],
          ),
        ),
        body: const Placeholder()
    );
  }
}
