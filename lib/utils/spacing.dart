import 'package:flutter/material.dart';

class Spacing extends SizedBox {
  final double? height;
  final double? width;
  Spacing({this.height, this.width}) : super(height: height, width: width);
}

double getHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double getWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}
