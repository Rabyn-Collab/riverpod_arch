import 'package:flutter/material.dart';
import 'package:flutterspod/models/product.dart';



class DetailPage extends StatelessWidget {
  final Product product;
  const DetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: const Placeholder()
    );
  }
}
