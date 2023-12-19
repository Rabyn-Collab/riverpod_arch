import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/constants/app_sizes.dart';
import 'package:flutterspod/provider/auth_provider.dart';
import 'package:flutterspod/views/main/add_form.dart';
import 'package:get/get.dart';



class HomePage extends ConsumerWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final users = ref.watch(allUsersStream);
    return Scaffold(
      appBar: AppBar(),
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                onTap: (){
                  Get.to(() => AddForm(), transition: Transition.leftToRight);
                },
                leading: Icon(Icons.add),
                title: Text('Create Post'),
              ),
              ListTile(
                onTap: (){
                  ref.read(authProvider.notifier).userLogOut();
                },
                leading: Icon(Icons.exit_to_app),
                title: Text('Sign Out'),
              ),

            ],
          ),
        ),
        body: Column(
          children: [
           Container(
             padding: EdgeInsets.all(10),
             height: 190,
             child: users.when(
                 data: (data){
                   return ListView.builder(
                     scrollDirection: Axis.horizontal,
                       itemCount: data.length,
                       itemBuilder: (context, index){
                         final user = data[index];
                         return Column(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                              CircleAvatar(
                                radius: 45,
                                 backgroundImage: NetworkImage(user.imageUrl!),
                              ),
                             AppSizes.gapH6,
                             Text(user.firstName!)
                           ],
                         );
                       }
                   );
                 },
                 error: (err, st) => Center(child: Text('$err')),
                 loading: () => Center(child: CircularProgressIndicator())
             ),
           ),
          ],
        ));
  }
}
