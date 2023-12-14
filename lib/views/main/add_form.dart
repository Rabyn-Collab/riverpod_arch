// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutterspod/common_widgets/toast_widget.dart';
// import 'package:flutterspod/constants/app_sizes.dart';
// import 'package:flutterspod/provider/auth_provider.dart';
// import 'package:flutterspod/provider/product_provider.dart';
// import 'package:flutterspod/shared/other_provider.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:get/get.dart';
//
//
// class AddForm extends ConsumerStatefulWidget {
//   const AddForm({super.key});
//
//   @override
//   ConsumerState<AddForm> createState() => _AddFormState();
// }
//
// class _AddFormState extends ConsumerState<AddForm> {
//   List<String> brand = ['Nike', 'Yoho', 'Addidas'];
//   List<String> category = ['sports', 'clothes', 'fashion'];
//   final _formKey = GlobalKey<FormBuilderState>();
//
//   @override
//   Widget build(BuildContext context) {
//     final mode = ref.watch(modeProvider);
//     ref.listen(productNotifier, (previous, next) {
//       if(next.isError){
//         Toasts.showError(message: next.errMsg);
//       }else if(next.isSuccess){
//         ref.invalidate(productProvider);
//         Get.back();
//         Toasts.showSuccess(message: 'successfully added');
//       }
//     });
//
//     final state = ref.watch(productNotifier);
//
//     final image = ref.watch(photoProvider);
//
//     return PopScope(
//       // canPop: auth.isLoading ? false: true,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Add Form'),
//         ),
//         body:Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           child: FormBuilder(
//             autovalidateMode: mode,
//             key: _formKey,
//             child: ListView(
//
//               children: [
//                 _buildFormBuilderTextField('product_name'),
//                 _buildFormBuilderTextField('product_detail'),
//
//                 buildFormBuilderDropdown(data: brand, hint: 'Select Brand', name: 'brand'),
//                 buildFormBuilderDropdown(data: category, hint: 'Select Category', name: 'category'),
//
//
//                 _buildFormBuilderTextField('countInStock'),
//                 _buildFormBuilderTextField('product_price'),
//                 AppSizes.gapH20,
//
//                 InkWell(
//                     onTap: (){
//                     ref.read(photoProvider.notifier).pickImage(false);
//                     },
//                     child: Container(
//                       height: 100,
//                       width: 100,
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.white)
//                       ),
//                       child: image == null ? Center(child: Text('please select an image')): Image.file(File(image.path)),
//                     )),
//
//                 AppSizes.gapH20,
//                 AppSizes.gapH16,
//                 MaterialButton(
//                   color: Colors.pink.shade300,
//                   onPressed: state.isLoading ? null : () {
//                     FocusScope.of(context).unfocus();
//                     if(_formKey.currentState!.saveAndValidate()){
//                       if(image == null){
//                           Toasts.showError(message: 'please select an image');
//                       }else{
//                           ref.read(productNotifier.notifier).addProduct(data: _formKey.currentState!.value, image: image);
//                       }
//
//                     }else{
//                       ref.read(modeProvider.notifier).change();
//                     }
//
//                   },
//                   child: state.isLoading ? Center(child: CircularProgressIndicator()): const Text('Submit'),
//                 ),
//
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   FormBuilderDropdown<String> buildFormBuilderDropdown({
//     required String name, required String hint, required List<String> data
// }) {
//     return FormBuilderDropdown<String>(
//                 name: name,
//                 decoration: InputDecoration(
//                   suffix: IconButton(
//                     icon: const Icon(Icons.close),
//                     onPressed: () {
//                       _formKey.currentState!.fields['brand']
//                           ?.reset();
//                     },
//                   ),
//                   hintText: hint,
//                 ),
//                 // validator: FormBuilderValidators.compose([
//                 //   FormBuilderValidators.required(),
//                 // ]),
//                 items: data
//                     .map((dat) => DropdownMenuItem(
//                   alignment: AlignmentDirectional.center,
//                   value: dat,
//                   child: Text(dat),
//                 ))
//                     .toList(),
//               );
//   }
//
//   FormBuilderTextField _buildFormBuilderTextField(String name) {
//     return FormBuilderTextField(
//       textInputAction: TextInputAction.next,
//       name: name,
//       decoration:  InputDecoration(
//         labelText: name,
//       ),
//       validator: FormBuilderValidators.compose([
//        // FormBuilderValidators.required(),
//                 ]),
//               );
//   }
// }
