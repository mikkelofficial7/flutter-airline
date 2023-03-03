import 'package:http/http.dart' as http;
import 'package:sample_flutter/model/model_list_airline.dart';
import 'dart:convert';
import '../../constants/pathconstant.dart';

class ApiProvider {
  final String apiUrl = PathConstant.baseUrl;

  Future<ListAirline> getListAirline(int page, int size) async {
    try {
      var queryParams = {
        "page": page.toString(),
        "size": size.toString()
      };

      Uri uri = Uri.http(
          apiUrl,
          PathConstant.pathUrl,
          queryParams
      );

      var result = await http.get(uri);
      return ListAirline.fromJson(json.decode(result.body));

    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ListAirline(totalPages: 0, totalPassengers: 0, data: []);

    }
  }
}