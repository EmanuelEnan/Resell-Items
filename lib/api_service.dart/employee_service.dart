import 'dart:convert';

import 'package:backend_flutter/constants.dart';
import 'package:backend_flutter/models/model.dart';

import 'package:http/http.dart' as http;

class ApiService {
  Constants constants = Constants();
  Future<List<Employees>> getApi() async {
    // var slug = userId;
    String url = constants.empCreate;

    // Map<String, String> qParams = {
    //   'userId': userId,
    // };

    Uri uri = Uri.parse(url);
    // final finalUri = uri.replace(queryParameters: qParams);

    final response = await http.get(
      uri,
    );
    print(uri);

    // final resp = response.body;
    // print(resp);

    if (response.statusCode == 200) {
      print(response.statusCode);
      // final resp = '[${response.body}]';
      final resp = response.body;
      print(resp);
      // Map services = jsonDecode(resp);

      // return Employees.fromJson(jsonDecode(resp));
      List service = (jsonDecode(resp) as List<dynamic>);
      return service.map((json) => Employees.fromJson(json)).toList();

      // return TwitterModel.fromJson(jsonDecode(resp));
      //
    } else {
      throw Exception('${response.statusCode}');
    }
  }
}
