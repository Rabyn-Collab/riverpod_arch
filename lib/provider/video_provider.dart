
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/service/api_service.dart';



final videoProvider = FutureProvider.family((ref, int id) => ref.read(apiService).getMovieVideo(id: id));