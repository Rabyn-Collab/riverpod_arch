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
    required Map<String, dynamic> data,required XFile image
  }) async{
    state = state.copyWith(isError: false, isSuccess: false, isLoading: true);
    final response = await service.addProduct(data: data, image: image);
    response.fold((l) {
      state = state.copyWith(isLoading: false, isError: true,isSuccess: false, errMsg: l);
    }, (r) {
      state = state.copyWith(isLoading: false, isError: false,isSuccess: true);
    });


  }


  }