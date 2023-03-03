import 'package:sample_flutter/api/provider/api_provider.dart';
import 'package:sample_flutter/model/model_list_airline.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<ListAirline> fetchListAirline(int page, int size) {
    return _provider.getListAirline(page, size);
  }
}

class NetworkError extends Error {}