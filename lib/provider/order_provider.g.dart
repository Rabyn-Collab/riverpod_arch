// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$orderServiceHash() => r'751850b2dc75e9e97e7aa978051c588ae792ae6e';

/// See also [orderService].
@ProviderFor(orderService)
final orderServiceProvider = AutoDisposeProvider<OrderService>.internal(
  orderService,
  name: r'orderServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$orderServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef OrderServiceRef = AutoDisposeProviderRef<OrderService>;
String _$orderHash() => r'd1ea1fe9f57acf15545b9b8509df340c48124f05';

/// See also [order].
@ProviderFor(order)
final orderProvider = AutoDisposeFutureProvider<List<OrderItem>>.internal(
  order,
  name: r'orderProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$orderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef OrderRef = AutoDisposeFutureProviderRef<List<OrderItem>>;
String _$orderUserHash() => r'4a7ad923fe55cafdd197e7f94d6324ef51b4948d';

/// See also [orderUser].
@ProviderFor(orderUser)
final orderUserProvider = AutoDisposeFutureProvider<List<OrderItem>>.internal(
  orderUser,
  name: r'orderUserProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$orderUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef OrderUserRef = AutoDisposeFutureProviderRef<List<OrderItem>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
