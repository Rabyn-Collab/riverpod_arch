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

@riverpod
Future<Product> productSingle(ProductSingleRef ref, String id) => ref.read(productServiceProvider).getProductById(id: id);


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



  Future<void>  updateProduct ({
    required Map<String, dynamic> data,
    XFile? image,
    String? imagePath,
    required String id
  }) async{
    state = state.copyWith(isError: false, isSuccess: false, isLoading: true);
    final response = await service.updateProduct(
        id: id,
        data: data, image: image, imagePath: imagePath);
    response.fold((l) {
      state = state.copyWith(isLoading: false, isError: true,isSuccess: false, errMsg: l);
    }, (r) {
      state = state.copyWith(isLoading: false, isError: false,isSuccess: true);
    });

  }


  Future<void>  addReview ({
    required String comment,
    required double  rating,
    required String username,
    required String id
  }) async{
    state = state.copyWith(isError: false, isSuccess: false, isLoading: true);
    final response = await service.addReview(comment: comment, rating: rating, username: username, id: id);
    response.fold((l) {
      state = state.copyWith(isLoading: false, isError: true,isSuccess: false, errMsg: l);
    }, (r) {
      state = state.copyWith(isLoading: false, isError: false,isSuccess: true);
    });
  }



    Future<void>  removeProduct ({
    required String id
  }) async{
    state = state.copyWith(isError: false, isSuccess: false, isLoading: true);
    final response = await service.removeProduct(id: id);
    response.fold((l) {

      state = state.copyWith(isLoading: false, isError: true,isSuccess: false, errMsg: l);
    }, (r) {
      state = state.copyWith(isLoading: false, isError: false,isSuccess: true);
    });

  }
  
  
  

  }