import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/service/api_service.dart';




final categoryProvider = FutureProvider((ref) => ApiService.getMealData());
final itemProvider =
FutureProvider.family((ref, String cata) =>
    ApiService.getMealItem(category: cata));

