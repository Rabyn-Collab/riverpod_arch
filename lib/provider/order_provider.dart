import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/models/crud_state.dart';
import 'package:flutterspod/models/order_item.dart';
import 'package:flutterspod/service/order_service.dart';
import 'package:flutterspod/shared/client_provider.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'order_provider.g.dart';

@riverpod
OrderService orderService (OrderServiceRef ref) => OrderService(ref.watch(authClientProvider));


@riverpod
Future<List<OrderItem>> order(OrderRef ref) => ref.read(orderServiceProvider).getAllOrders();

@riverpod
Future<List<OrderItem>> orderUser(OrderRef ref) => ref.read(orderServiceProvider).getOrderUser();

final orderNotifier = StateNotifierProvider.autoDispose<OrderNotifier, CrudState>(
        (ref) => OrderNotifier(CrudState.empty(), ref.watch(orderServiceProvider)));

class OrderNotifier extends StateNotifier<CrudState>{
  final OrderService service;
  OrderNotifier(super.state, this.service);



  Future<void>  addOrder ({
    required List<Map<String, dynamic>> orderItems,
    required int totalPrice,
  }) async{
    state = state.copyWith(isError: false, isSuccess: false, isLoading: true);
    final response = await service.addOrder(orderItems: orderItems, totalPrice: totalPrice);
    response.fold((l) {
      state = state.copyWith(isLoading: false, isError: true,isSuccess: false, errMsg: l);
    }, (r) {
      state = state.copyWith(isLoading: false, isError: false,isSuccess: true);
    });
  }







}