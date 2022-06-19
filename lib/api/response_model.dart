import 'package:bliss_shopping/modules/product/model/product.dart';

class ResponseModel {
  bool? status;
  List<Product>? products;
  String? error;

  ResponseModel({this.status, this.products});

  ResponseModel.withError(String errorMessage) {
    error = errorMessage;
  }

  ResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      products = [];
      json['result'].forEach((v) {
        products!.add(Product.fromJson(v));
      });
    }
  }
}
