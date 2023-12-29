import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/constants/app_sizes.dart';
import 'package:flutterspod/firebase_service.dart';
import 'package:flutterspod/provider/auth_provider.dart';
import 'package:flutterspod/provider/post_provider.dart';
import 'package:flutterspod/views/main/add_form.dart';
import 'package:flutterspod/views/main/detail_page.dart';
import 'package:flutterspod/views/main/edit_form.dart';
import 'package:flutterspod/views/main/recent_chats.dart';
import 'package:flutterspod/views/user_detail.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends ConsumerStatefulWidget{


  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final uid = FirebaseAuth.instance.currentUser!.uid;

  late types.User currentUser;


  @override
  void initState() {
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        FirebaseService.createanddisplaynotification(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message.notification != null) {
          FirebaseService.createanddisplaynotification(message);
      }
    });


    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        FirebaseService.createanddisplaynotification(message);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final users = ref.watch(allUsersStream);
    final posts = ref.watch(postsStream);
    final userState = ref.watch(userProfileStream(uid));
    return Scaffold(
      appBar: AppBar(),
        drawer: Drawer(
          child: ListView(
            children: [
              userState.when(
                  data: (data){
                    currentUser = data;
                    return DrawerHeader(
                        decoration: BoxDecoration(
                          image: DecorationImage(image: NetworkImage(data.imageUrl!))
                        ),
                        child: Text(data.firstName!)
                    );
                  },
                  error: (err,st) => Center(child: Text('$err')),
                  loading: () => Center(child: CircularProgressIndicator())
              ),
              ListTile(
                onTap: (){
                  Navigator.of(context).pop();
                  Get.to(() => RecentChats(), transition: Transition.leftToRight);
                },
                leading: Icon(Icons.message),
                title: Text('Recent Chats'),
              ),
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
                         return InkWell(
                           onTap: (){
                             Get.to(() => UserDetail(
                                  currentUser: currentUser.firstName!,
                                 user: user), transition:  Transition.leftToRight);
                           },
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: [
                                CircleAvatar(
                                  radius: 45,
                                   backgroundImage: CachedNetworkImageProvider(user.imageUrl!),
                                ),
                               AppSizes.gapH6,
                               Text(user.firstName!)
                             ],
                           ),
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
                        return InkWell(
                          onTap: (){
                            Get.to(() => DetailPage(postId: post.id, user: currentUser), transition: Transition.leftToRight);
                          },
                          child: Card(
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
                                                  IconButton(onPressed: (){
                                                    Navigator.of(context).pop();
                                                    Get.to(() => EditForm(post: post), transition:  Transition.leftToRight);
                                                  }, icon: Icon(Icons.edit)),
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
                                      child: CachedNetworkImage(imageUrl:post.imageUrl),
                                    ),
                                  ),
                                  Padding(
                                    padding:uid != post.userId ?
                                    EdgeInsets.symmetric(vertical: 0, horizontal: 10) :  const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(child: Text(post.detail)),
                                        if(uid != post.userId) Row(
                                          children: [
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  padding: EdgeInsets.zero,
                                                ),
                                                onPressed: (){
                                                  if(post.like.usernames.contains(currentUser.firstName)){

                                                  }else{
                                                    ref.read(postNotifier.notifier).addLike(
                                                        postId: post.id,
                                                        usernames: [...post.like.usernames, currentUser.firstName!],
                                                        like: post.like.likes
                                                    );
                                                  }
                                                }, child: Icon(Icons.thumb_up)),
                                            if(post.like.likes > 0 ) Text('${post.like.likes}')
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )
                          ),
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
