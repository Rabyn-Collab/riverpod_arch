import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/constants/app_sizes.dart';
import 'package:flutterspod/provider/auth_provider.dart';
import 'package:flutterspod/shared/other_provider.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';


class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final mode = ref.watch(modeProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
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
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
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
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                   if(_formKey.currentState!.saveAndValidate()){
                     ref.read(authProvider.notifier).userLogin(data: _formKey.currentState!.value);
                   }else{
                   ref.read(modeProvider.notifier).state = AutovalidateMode.onUserInteraction;
                   }

                  },
                  child: const Text('Login'),
                )
              ],
            ),
          ),
        ),
    );
  }
}
