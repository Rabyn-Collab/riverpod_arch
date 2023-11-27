import 'package:flutterspod/models/product.dart';
import 'package:flutterspod/service/product_service.dart';
import 'package:flutterspod/shared/client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'product_provider.g.dart';

@riverpod
ProductService productService (ProductServiceRef ref) => ProductService(ref.watch(clientProvider));

// final productServiceProvider = Provider((ref) => ProductService(ref.watch(clientProvider)));

@riverpod
Future<List<Product>> product(ProductRef ref) => ref.read(productServiceProvider).getProducts();


//final productProvider = FutureProvider((ref) => ref.read(productServiceProvider).getProducts());