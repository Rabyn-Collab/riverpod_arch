import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ext_provider.g.dart';


@riverpod
class Toggle extends _$Toggle{

   @override
  bool build(){
     return true;
   }

   void change(){
     state = !state;
   }
}


@riverpod
class ImageC extends _$ImageC{

  @override
  XFile? build(){
    return null;
  }

    void pickImage() async{
      final picker = ImagePicker();
      state = await picker.pickImage(source: ImageSource.gallery);
    }
}


