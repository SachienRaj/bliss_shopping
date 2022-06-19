import 'package:bliss_shopping/api/response_model.dart';
import 'package:dio/dio.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _url =
      'https://run.mocky.io/v3/919a0d45-c054-4452-8175-65538e554272';

  Future<ResponseModel> fetchProductList() async {
    try {
      Response response = await _dio.get(_url);
      return ResponseModel.fromJson(response.data);
    } catch (error, stacktrace) {
      // ignore: avoid_print
      print("Exception occured: $error stackTrace: $stacktrace");
      return ResponseModel.withError("Data not found / Connection issue");
    }
  }
}
