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
String _$productSingleHash() => r'a9e95a368064ebf3500f5d564d06678991f3dbe5';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [productSingle].
@ProviderFor(productSingle)
const productSingleProvider = ProductSingleFamily();

/// See also [productSingle].
class ProductSingleFamily extends Family<AsyncValue<Product>> {
  /// See also [productSingle].
  const ProductSingleFamily();

  /// See also [productSingle].
  ProductSingleProvider call(
    String id,
  ) {
    return ProductSingleProvider(
      id,
    );
  }

  @override
  ProductSingleProvider getProviderOverride(
    covariant ProductSingleProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'productSingleProvider';
}

/// See also [productSingle].
class ProductSingleProvider extends AutoDisposeFutureProvider<Product> {
  /// See also [productSingle].
  ProductSingleProvider(
    String id,
  ) : this._internal(
          (ref) => productSingle(
            ref as ProductSingleRef,
            id,
          ),
          from: productSingleProvider,
          name: r'productSingleProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productSingleHash,
          dependencies: ProductSingleFamily._dependencies,
          allTransitiveDependencies:
              ProductSingleFamily._allTransitiveDependencies,
          id: id,
        );

  ProductSingleProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<Product> Function(ProductSingleRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProductSingleProvider._internal(
        (ref) => create(ref as ProductSingleRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Product> createElement() {
    return _ProductSingleProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductSingleProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ProductSingleRef on AutoDisposeFutureProviderRef<Product> {
  /// The parameter `id` of this provider.
  String get id;
}

class _ProductSingleProviderElement
    extends AutoDisposeFutureProviderElement<Product> with ProductSingleRef {
  _ProductSingleProviderElement(super.provider);

  @override
  String get id => (origin as ProductSingleProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
