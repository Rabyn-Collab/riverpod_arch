import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/constants/app_sizes.dart';
import 'package:flutterspod/models/post.dart';
import 'package:flutterspod/provider/post_provider.dart';
import 'package:flutterspod/shared/ext_provider.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';






class EditForm extends ConsumerStatefulWidget{
  final Post post;
  const EditForm({super.key, required this.post});

  @override
  ConsumerState<EditForm> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<EditForm> {
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
                  _buildFormBuilderTextField(
                      val: widget.post.title,
                      label: 'Title', name: 'title'),
                  AppSizes.gapH10,
                  _buildFormBuilderTextField(
                    val: widget.post.detail,
                    label: 'Detail', name: 'detail',),
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
                      child: image == null ?
                      Center(child: Image.network(widget.post.imageUrl)): Image.file(File(image.path)),
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
                          ref.read(postNotifier.notifier).updatePost(
                              title: map['title'],
                              detail: map['detail'],
                              postId: widget.post.id
                          );
                        }else{
                          ref.read(postNotifier.notifier).updatePost(
                              title: map['title'],
                              detail: map['detail'],
                              image: image,
                            imageId: widget.post.imageId,
                            postId: widget.post.id
                          );
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
    required String val,
    bool? isLast,
  }) {
    return Consumer(
        builder: (c, ref, child) {
          // final mode = ref.watch(modeProvider);
          // final toggle = ref.watch(toggleProvider);
          return FormBuilderTextField(
            initialValue: val,
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


