import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/constants/app_sizes.dart';
import 'package:flutterspod/provider/auth_provider.dart';
import 'package:flutterspod/views/main/admin_page/product_list.dart';
import 'package:get/get.dart';



class DrawerWidget extends StatelessWidget{
  final WidgetRef ref;
  const DrawerWidget({super.key, required this.ref});

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authProvider);
    return  Drawer(
      child: ListView(
        children: [
           AppSizes.gapH14,
          if(state.user?.isAdmin == true)  ListTile(
            onTap: (){
              Get.back();
              Get.to(() => ProductList(), transition:  Transition.leftToRight);
            },
            leading: Icon(Icons.propane_tank),
            title: Text('product list'),
          ),
          ListTile(
            onTap: (){
              ref.read(authProvider.notifier).userLogOut();
            },
            leading: Icon(Icons.exit_to_app),
            title: Text('userLogOut'),
          ),

        ],
      ),
    );
  }
}
