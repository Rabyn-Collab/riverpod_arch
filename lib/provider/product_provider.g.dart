// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productServiceHash() => r'b93c2a3f0f2ee650fa75a328c5865e620579f719';

/// See also [productService].
@ProviderFor(productService)
final productServiceProvider = AutoDisposeProvider<ProductService>.internal(
  productService,
  name: r'productServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$productServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ProductServiceRef = AutoDisposeProviderRef<ProductService>;
String _$productHash() => r'9af33d5730db4b5a5fc6d3b372cc8b58cbd62ee3';

/// See also [product].
@ProviderFor(product)
final productProvider = AutoDisposeFutureProvider<List<Product>>.internal(
  product,
  name: r'productProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$productHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ProductRef = AutoDisposeFutureProviderRef<List<Product>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member