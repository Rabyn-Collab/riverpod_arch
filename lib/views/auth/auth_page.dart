import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/constants/app_sizes.dart';
import 'package:flutterspod/provider/auth_provider.dart';
import 'package:flutterspod/shared/ext_provider.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';






class AuthPage extends ConsumerStatefulWidget{
  const AuthPage({super.key});

  @override
  ConsumerState<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage> {
  final _formKey = GlobalKey<FormBuilderState>();





  @override
  Widget build(BuildContext context) {


  ref.listen(authProvider, (previous, next) {
      if(next.hasError && !next.isLoading){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(seconds: 1),
            content: Text(next.error.toString())));
      }
    });

  final auth = ref.watch(authProvider);
  final isLogin = ref.watch(toggleProvider);
  final image = ref.watch(imageCProvider);
    return Scaffold(
      body: SafeArea(
        child: FormBuilder(
             key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                 if(!isLogin) _buildFormBuilderTextField(label: 'Username', name: 'username'),
                  AppSizes.gapH10,
                  _buildFormBuilderTextField(label: 'Email', name: 'email', isEmail: true,),
                  AppSizes.gapH10,

                  _buildFormBuilderTextField(label: 'Password', name: 'password', isPassword: true, isLast: true),
                 AppSizes.gapH10,
                 AppSizes.gapH10,
                 AppSizes.gapH10,

                  if(!isLogin)  InkWell(
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



                  if(!isLogin)   AppSizes.gapH10,
                 AppSizes.gapH10,
                 AppSizes.gapH10,
                  ElevatedButton(
                        onPressed: auth.isLoading ? null : () {
                          FocusScope.of(context).unfocus();
                          if (_formKey.currentState!.saveAndValidate(focusOnInvalid: false)) {
                            final map= _formKey.currentState!.value;
                            if(isLogin){
                              ref.read(authProvider.notifier).userLogin(
                                  data: _formKey.currentState!.value);
                            }else{
                              if(image == null){

                              }else{
                                ref.read(authProvider.notifier).userRegister(
                                    email: map['email'],
                                    password: map['password'],
                                    username: map['username'],
                                    image: image);
                              }
                            }

                          } else {
                           // ref.read(modeProvider.notifier).change();
                          }
                        },
                        child: auth.isLoading ? Center(
                            child: CircularProgressIndicator()) : const Text('Login'),
                      ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(isLogin ? 'Don\'t have an account': 'Already have an account'),
                      TextButton(onPressed: (){
                        ref.read(toggleProvider.notifier).change();
                      }, child: Text(isLogin ? 'Sign Up': 'Login'))
                    ],
                  )
                ],
              ),
            )
        ),
      ),
    );
  }

  Consumer _buildFormBuilderTextField({
     bool? isEmail,
     bool? isPassword,
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
          if(isEmail !=null)  FormBuilderValidators.email(),
          ]),
        );
      }
    );
  }
}


