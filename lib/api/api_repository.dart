import 'package:bliss_shopping/api/response_model.dart';
import 'api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<ResponseModel> fetchProductList() {
    return _provider.fetchProductList();
  }
}

class NetworkError extends Error {}
