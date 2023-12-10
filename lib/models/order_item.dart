import 'package:freezed_annotation/freezed_annotation.dart';


part 'order_item.freezed.dart';
part 'order_item.g.dart';

@freezed
class OrderItem with _$OrderItem{

  const factory OrderItem({
    required List<OrderData> orderItems,
    required int totalPrice,
    required String createdAt
  }) = _OrderItem;

  factory OrderItem.fromJson(Map<String, Object?> json) => _$OrderItemFromJson(json);

}





@freezed
class OrderData with _$OrderData{

  const factory OrderData({
   required String name,
   required int  qty,
   required String image,
   required int  price,
   required String product,

  }) = _OrderData;

  factory OrderData.fromJson(Map<String, Object?> json) => _$OrderDataFromJson(json);

}





