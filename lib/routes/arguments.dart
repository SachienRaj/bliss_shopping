import 'package:bliss_shopping/modules/product/model/product.dart';
import 'package:flutter/material.dart';

class Arguments {
  final Color pageColor;
  final List<Product> products;
  final String categoryName;
  final Product product;

  Arguments(this.pageColor, this.products, this.categoryName, this.product);
}
