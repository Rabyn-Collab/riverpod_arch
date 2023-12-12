import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterspod/common_widgets/toast_widget.dart';
import 'package:flutterspod/constants/app_sizes.dart';
import 'package:flutterspod/models/user.dart';
import 'package:flutterspod/provider/cart_provider.dart';

import '../../models/product.dart';



class DetailPage extends ConsumerStatefulWidget {
  final Product product;
  final User? user;
  const DetailPage({super.key, required this.product, required this.user});

  @override
  ConsumerState<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends ConsumerState<DetailPage> {
  double rating = 1;
  final commentControl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(widget.product.product_image),
            AppSizes.gapH20,
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.product.product_name),
                  Text(widget.product.product_detail),
                  AppSizes.gapH12,
                  AppSizes.gapH12,
                  Text('Add Comments'),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white24
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 25,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                         setState(() {
                           rating = rating;
                         });
                      },
                    ),
                    TextFormField(
                      controller: commentControl,
                    ),
                    AppSizes.gapH12,
                    AppSizes.gapH12,
                    ElevatedButton(onPressed: (){
                      print(commentControl.text);
                      FocusScope.of(context).unfocus();
                      if(commentControl.text.isEmpty){
                        Toasts.showError(message: 'comment field required');
                      }else if(commentControl.text.length > 15){

                      }else{
                        Toasts.showError(message: 'max 10 over character required');
                      }
                    }, child: Text('Submit'))
                  ],
                ),
              )
                ],
              ),
            ),


           Expanded(
               child: ListView.builder(
                   itemCount: widget.product.reviews.length,
                   itemBuilder: (context, index){
                     final rev = widget.product.reviews[index];
                     return ListTile(
                       leading: Icon(Icons.person_3_outlined),
                        title: Text(rev.username),
                       trailing: RatingBarIndicator(
                         rating: rev.rating.toDouble(),
                         itemBuilder: (context, index) => Icon(
                           Icons.star,
                           color: Colors.amber,
                         ),
                         itemCount: 5,
                         itemSize: 20.0,
                         direction: Axis.horizontal,
                       ),
                       subtitle: Text(rev.comment),
                     );
                   })
           ),
           if(widget.user?.isAdmin == false) Consumer(
             builder: (context, ref, child) {

               return ElevatedButton(
                   onPressed: () {
                      ref.read(cartProvider.notifier).addToCart(widget.product, context);
                   }, child: Text('Add To Cart'));
             }
           ),
            AppSizes.gapH20,
          ],
        )
    );
  }
}
