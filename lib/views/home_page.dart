import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/constants/app_sizes.dart';
import 'package:flutterspod/models/todo.dart';
import 'package:flutterspod/provider/todo_provider.dart';
import 'package:intl/intl.dart';


class HomePage extends ConsumerWidget {


  final todoController = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(todoProvider);

    return Scaffold(
        body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                TextFormField(
                  controller: todoController,
                  onFieldSubmitted: (val){
                   if(val.isEmpty){
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                       duration: Duration(seconds: 1),
                         content: Text('please provide value')
                     ));
                   }else{
                     ref.read(todoProvider.notifier).addTodo(
                       Todo(DateTime: DateTime.now().toString(), todo: val.trim())
                     );
                     todoController.clear();
                   }
                  },
                  decoration: InputDecoration(
                    hintText: 'add some todo',
                    prefixIcon: Icon(Icons.abc)
                  ),
                ),
                  AppSizes.gapH14,
                  Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                          itemBuilder: (context, index){
                            final todo = state[index];
                            final date = DateTime.parse(todo.DateTime);
                            final d = DateFormat.yMd().format(date);
                            print(d);
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Icon(Icons.task),
                              title: Text(todo.todo),
                              subtitle: Text('createdAt:- $d'),
                              trailing: Container(
                                width: 100,
                                child: Row(
                                  children: [
                                    IconButton(

                                        onPressed: (){}, icon: Icon(Icons.edit)),
                                    IconButton(

                                        onPressed: (){
                                          ref.read(todoProvider.notifier).removeTodo(index);
                                        }, icon: Icon(Icons.delete)),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (c, i){
                            return Divider();
                          },
                          itemCount: state.length
                      )
                  )
                ],
              ),
            )
        )
    );
  }
}
