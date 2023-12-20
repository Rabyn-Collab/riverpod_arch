import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/constants/app_sizes.dart';
import 'package:flutterspod/provider/auth_provider.dart';
import 'package:flutterspod/provider/post_provider.dart';
import 'package:flutterspod/views/main/add_form.dart';
import 'package:get/get.dart';



class HomePage extends ConsumerWidget{
   HomePage({super.key});

  final uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context, ref) {

    final users = ref.watch(allUsersStream);
    final posts = ref.watch(postsStream);
    return Scaffold(
      appBar: AppBar(),
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                onTap: (){
                  Navigator.of(context).pop();
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
             height: 165,
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
                 loading: () => Container()
             ),
           ),
            Expanded(child: posts.when(
                data: (data){
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index){
                        final post = data[index];
                        return Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:uid == post.userId ?
                               EdgeInsets.symmetric(vertical: 0, horizontal: 10) :  const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(child: Text(post.title)),
                                     if(uid == post.userId) ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                          ),
                                          onPressed: (){
                                            Get.defaultDialog(
                                              title: 'Edit or Remove',
                                              content: Text(''),
                                              actions: [
                                                IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
                                                IconButton(onPressed: (){}, icon: Icon(Icons.delete)),
                                              ]
                                            );
                                          }, child: Icon(Icons.more_horiz_outlined))
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 300,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: Image.network(post.imageUrl),
                                  ),
                                ),
                                Padding(
                                  padding:uid != post.userId ?
                                  EdgeInsets.symmetric(vertical: 0, horizontal: 10) :  const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(child: Text(post.detail)),
                                      if(uid != post.userId) ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                          ),
                                          onPressed: (){}, child: Icon(Icons.thumb_up))
                                    ],
                                  ),
                                ),
                              ],
                            )
                        );
                      }
                  );
                },
                error: (err, st) {

                  return Text('$err');
                },
                loading: () => Center(child: CircularProgressIndicator())
            ))
          ],
        ));
  }
}
