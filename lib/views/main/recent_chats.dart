import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/provider/chat_room_provider.dart';
import 'package:flutterspod/views/main/chat_page.dart';
import 'package:get/get.dart';


class RecentChats extends ConsumerWidget {
  const RecentChats({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(roomStream);
    return Scaffold(
        body: SafeArea(
          child: state.when(
              data: (data){

                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index){
                      final user = data[index].users.firstWhere((element) => element.id != FirebaseAuth.instance.currentUser!.uid);

                      return Card( 
                        child: ListTile(
                          onTap: (){
                           Get.to(() => ChatPage(room: data[index], token: user.metadata!['token']), transition: Transition.leftToRight);
                          },
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(data[index].imageUrl!),
                          ),
                          title: Text(data[index].name!),
                        ),
                      );
                    }
                );
              },
              error: (err, st) => Center(child: Text('$err')),
              loading: () => Center(child: CircularProgressIndicator())
          ),
        )
    );
  }
}
