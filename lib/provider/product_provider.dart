import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/models/crud_state.dart';
import 'package:flutterspod/models/product.dart';
import 'package:flutterspod/service/product_service.dart';
import 'package:flutterspod/shared/client_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'product_provider.g.dart';

@riverpod
ProductService productService (ProductServiceRef ref) => ProductService( ref.watch(authClientProvider), ref.watch(clientProvider));

// final productServiceProvider = Provider((ref) => ProductService(ref.watch(clientProvider)));

@riverpod
Future<List<Product>> product(ProductRef ref) => ref.read(productServiceProvider).getProducts();


//final productProvider = FutureProvider((ref) => ref.read(productServiceProvider).getProducts());


final productNotifier = StateNotifierProvider.autoDispose<ProductNotifier, CrudState>(
        (ref) => ProductNotifier(CrudState.empty(), ref.watch(productServiceProvider)));

class ProductNotifier extends StateNotifier<CrudState>{
  final ProductService service;
  ProductNotifier(super.state, this.service);



  Future<void>  addProduct ({
    required String product_name,
    required String product_detail,
    required int product_price,
    required XFile product_image,
    required String  brand,
    required String category,
    required int countInStock,
  }) async {
    state = state.copyWith(isError: false, isSuccess: false, isLoading: true);
    final response = await service.addProduct(
        product_name: product_name, product_detail: product_detail,
        product_price: product_price, product_image: product_image, brand: brand, category: category, countInStock: countInStock);
    response.fold((l) {
      state = state.copyWith(isLoading: false, isError: true,isSuccess: false, errMsg: l);
    }, (r) {
      state = state.copyWith(isLoading: false, isError: false,isSuccess: true);
    });


  }


  }