import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/provider/order_provider.dart';
import 'package:intl/intl.dart';



class OrderHistory extends ConsumerWidget {
  const OrderHistory({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(orderUserProvider);
    return Scaffold(
        body: SafeArea(
            child: state.when(data: (data){

              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final or = data[index];
                  final date = DateFormat('yMEd').format(DateTime.parse(or.createdAt));
                  return Card(
                    child: ExpansionTile(
                        title: Text(date, maxLines: 1,),
                      subtitle: Text('Total Rs${or.totalPrice}'),
                      children: or.orderItems.map((e){
                        return Row(
                          children: [
                            Expanded(child: Image.network(e.image, height: 200,)),
                            Expanded(child: Column(
                              children: [
                                Text(e.name),
                                Text('${e.qty} X ${e.price}'),
                              ],
                            )),
                          ],
                        );
                      }).toList(),
                    ),
                  );
                }
              );
            }, error:(err, st) =>  Center(child: Text('$err')),
                loading: () => Center(child: CircularProgressIndicator())
            )
        )
    );
  }
}
