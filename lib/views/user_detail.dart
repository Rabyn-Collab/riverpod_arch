import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutterspod/constants/app_sizes.dart';
import 'package:flutterspod/provider/chat_room_provider.dart';
import 'package:flutterspod/provider/post_provider.dart';
import 'package:flutterspod/views/main/chat_page.dart';
import 'package:get/get.dart';

class UserDetail extends ConsumerWidget {
  final types.User user;
  const UserDetail({super.key, required this.user});

  @override
  Widget build(BuildContext context, ref) {

    ref.listen(roomNotifier, (previous, next) {
      if(next.hasError && !next.isLoading){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                duration: Duration(seconds: 1),
                content: Text(next.error.toString())));
      }else if(!next.hasError && !next.isLoading){
       Get.to(() => ChatPage(room: next.value, token: user.metadata!['token']), transition: Transition.leftToRight);
      }
    });
    final state = ref.watch(userPostStream(user.id));
    final roomState = ref.watch(singleRoomStream(user.id));
    return Scaffold(
        body: SafeArea(
            child: state.when(
                data: (data){
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 36,
                              backgroundImage: NetworkImage(user.imageUrl!),
                            ),
                            AppSizes.gapW20,
                            Column(
                              children: [
                                Text(user.firstName!),

                                roomState.when(
                                    data: (data){
                              return   ElevatedButton(
                                  onPressed: (){
                                    ref.read(roomNotifier.notifier).createRoom(user: user);
                                  }, child: Text('Start Chat'));
                                    }, error: (err, st) => Center(child: Text('$err')), loading: () => Center(child: CircularProgressIndicator()))

                              ],
                            )
                          ],
                        ),
                        Expanded(
                            child: Container())
                      ],
                    ),
                  );
                },
                error: (err, st) => Center(child: Text('$err')),
                loading: () => Center(child: CircularProgressIndicator())
            )
        )
    );
  }
}
