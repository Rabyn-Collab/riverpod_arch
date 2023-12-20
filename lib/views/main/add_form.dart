import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/constants/app_sizes.dart';
import 'package:flutterspod/provider/post_provider.dart';
import 'package:flutterspod/shared/ext_provider.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';






class AddForm extends ConsumerStatefulWidget{
  const AddForm({super.key});

  @override
  ConsumerState<AddForm> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AddForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  final uid = FirebaseAuth.instance.currentUser!.uid;




  @override
  Widget build(BuildContext context) {


    ref.listen(postNotifier, (previous, next) {
      if(next.hasError && !next.isLoading){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                duration: Duration(seconds: 1),
                content: Text(next.error.toString())));
      }else if(!next.isLoading && !next.hasError){
        Navigator.of(context).pop();
      }
    });

    final auth = ref.watch(postNotifier);
    final image = ref.watch(imageCProvider);
    return Scaffold(
      body: SafeArea(
        child: FormBuilder(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  _buildFormBuilderTextField(label: 'Title', name: 'title'),
                  AppSizes.gapH10,
                  _buildFormBuilderTextField(label: 'Detail', name: 'detail',),
                  AppSizes.gapH10,

                  AppSizes.gapH10,
                  AppSizes.gapH10,

                   InkWell(
                    onTap: (){
                      ref.read(imageCProvider.notifier).pickImage();
                    },
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white)
                      ),
                      child: image == null ? Center(child: Text('please select an image')): Image.file(File(image.path)),
                    ),
                  ),



                   AppSizes.gapH10,
                  AppSizes.gapH10,
                  AppSizes.gapH10,
                  ElevatedButton(
                    onPressed: auth.isLoading ? null : () {
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState!.saveAndValidate(focusOnInvalid: false)) {
                        final map= _formKey.currentState!.value;

                          if(image == null){

                          }else{
                            ref.read(postNotifier.notifier).createPost(
                              title: map['title'],
                                detail: map['detail'],
                                userId: uid,
                                image: image);
                          }


                      } else {
                        // ref.read(modeProvider.notifier).change();
                      }
                    },
                    child: auth.isLoading ? Center(
                        child: CircularProgressIndicator()) : const Text('Submit'),
                  ),

                ],
              ),
            )
        ),
      ),
    );
  }

  Consumer _buildFormBuilderTextField({

    required String name,
    required String label,
    bool? isLast,
  }) {
    return Consumer(
        builder: (c, ref, child) {
          // final mode = ref.watch(modeProvider);
          // final toggle = ref.watch(toggleProvider);
          return FormBuilderTextField(
            textInputAction: isLast == null ? TextInputAction.next: TextInputAction.done,
            name: name,
            //autovalidateMode: mode,
            //  obscureText: isPassword !=null ? toggle ? false: true  : false,
            decoration:  InputDecoration(
              labelText: label,
              // suffixIcon: isPassword !=null ? IconButton(onPressed: (){
              //   ref.read(toggleProvider.notifier).change();
              // }, icon: Icon(toggle ? Icons.check: Icons.close)) : null,
            ),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),

            ]),
          );
        }
    );
  }
}


