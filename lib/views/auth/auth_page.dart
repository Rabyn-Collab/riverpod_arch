import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/constants/app_sizes.dart';
import 'package:flutterspod/provider/auth_provider.dart';
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
    return Scaffold(
      body: SafeArea(
        child: FormBuilder(
             key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  _buildFormBuilderTextField(label: 'Email', name: 'email', isEmail: true,),
                  AppSizes.gapH10,
                  AppSizes.gapH10,
                  _buildFormBuilderTextField(label: 'Password', name: 'password', isPassword: true, isLast: true),
                 AppSizes.gapH10,
                 AppSizes.gapH10,
                 AppSizes.gapH10,
                  ElevatedButton(
                        onPressed: auth.isLoading ? null : () {
                          FocusScope.of(context).unfocus();
                          if (_formKey.currentState!.saveAndValidate(focusOnInvalid: false)) {
                            ref.read(authProvider.notifier).userLogin(
                                data: _formKey.currentState!.value);
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
                      Text('Don\'t have an account'),
                      TextButton(onPressed: (){

                      }, child: Text('Sign Up'))
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


