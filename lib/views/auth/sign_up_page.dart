import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/common_widgets/toast_widget.dart';
import 'package:flutterspod/constants/app_sizes.dart';
import 'package:flutterspod/provider/auth_provider.dart';
import 'package:flutterspod/provider/user_notifier.dart';
import 'package:flutterspod/provider/user_notifier.dart';
import 'package:flutterspod/provider/user_notifier.dart';
import 'package:flutterspod/shared/other_provider.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';


class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignPageState();
}

class _SignPageState extends ConsumerState<SignUpPage> {

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final mode = ref.watch(modeProvider);
    ref.listen(authProvider, (previous, next) {
      if(next.isError){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('healksjdlskajsdasadlkj')));
        //Toasts.showError(message: next.errMsg);
      }else if(next.isSuccess){
        Get.back();
        Toasts.showSuccess(message: 'successfully register');
      }
    });

    final auth = ref.watch(authProvider);
    final toggle = ref.watch(toggleProvider);


    return PopScope(
      // canPop: auth.isLoading ? false: true,
      child: Scaffold(
        appBar: AppBar(
          title: Text('SignUp'),
        ),
        body:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: FormBuilder(
            autovalidateMode: mode,
            key: _formKey,
            child: ListView(
              children: [
                FormBuilderTextField(
                  textInputAction: TextInputAction.next,
                  name: 'fullname',
                  decoration: const InputDecoration(
                    labelText: 'Full Name',

                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
                AppSizes.gapH10,
                AppSizes.gapH10,
                FormBuilderTextField(
                  textInputAction: TextInputAction.next,
                  name: 'email',
                  decoration: const InputDecoration(
                    labelText: 'Email',

                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.email(),
                  ]),
                ),
                AppSizes.gapH10,
                AppSizes.gapH10,
                FormBuilderTextField(
                  textInputAction: TextInputAction.done,
                  name: 'password',
                  decoration:  InputDecoration(
                      suffixIcon: IconButton(onPressed: (){
                        ref.read(toggleProvider.notifier).change();
                        print(toggle);
                      }, icon: Icon(toggle ? Icons.check: Icons.close)),
                      labelText: 'Password'),
                  obscureText: toggle ? false: true,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.min(6),
                    FormBuilderValidators.max(20),
                  ]),
                ),
                AppSizes.gapH20,
                AppSizes.gapH16,
                MaterialButton(
                  color: Theme.of(context).colorScheme.secondary,
                  onPressed: auth.isLoading ? null : () {
                    FocusScope.of(context).unfocus();
                    if(_formKey.currentState!.saveAndValidate()){
                      ref.read(authProvider.notifier).userRegister(data: _formKey.currentState!.value);
                    }else{
                      ref.read(modeProvider.notifier).change();
                    }

                  },
                  child: auth.isLoading ? Center(child: CircularProgressIndicator()): const Text('SignUp'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account'),
                    TextButton(onPressed: (){
                      Get.back();
                    }, child: Text('Login'))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
