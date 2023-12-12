import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/common_widgets/toast_widget.dart';
import 'package:flutterspod/constants/app_sizes.dart';
import 'package:flutterspod/provider/auth_provider.dart';
import 'package:flutterspod/shared/other_provider.dart';
import 'package:flutterspod/views/main/user_page/order_page.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class ShippingPage extends ConsumerStatefulWidget {
  const ShippingPage({super.key});

  @override
  ConsumerState<ShippingPage> createState() => _ShippingPageState();
}

class _ShippingPageState extends ConsumerState<ShippingPage> {

  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {

    ref.listen(authProvider, (previous, next) {
      if(next.isError){
        Toasts.showError(message: next.errMsg);
      }else if(next.isSuccess){
        Get.to(()=> OrderPage(), transition:  Transition.leftToRight);
      }
    });
    final mode = ref.watch(modeProvider);

    final auth = ref.watch(authProvider);
    final toggle = ref.watch(toggleProvider);


    return PopScope(
      // canPop: auth.isLoading ? false: true,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Shipping'),
        ),
        body:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: FormBuilder(
            autovalidateMode: mode,
            key: _formKey,
            child: ListView(
              children: [
                FormBuilderTextField(
                  controller: addressController,
                  textInputAction: TextInputAction.next,
                  name: 'address',
                  decoration: const InputDecoration(
                    labelText: 'address',
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),

                  ]),
                ),
                AppSizes.gapH10,
                AppSizes.gapH10,
                FormBuilderTextField(
                  controller: cityController,
                  textInputAction: TextInputAction.done,
                  name: 'city',
                  decoration:  InputDecoration(
                      labelText: 'city'),
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
                      ref.read(authProvider.notifier).addressUpdate(data: _formKey.currentState!.value, token: auth.user!.token);
                    }else{
                      ref.read(modeProvider.notifier).change();
                    }

                  },
                  child: auth.isLoading ? Center(child: CircularProgressIndicator()): const Text('Submit'),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
