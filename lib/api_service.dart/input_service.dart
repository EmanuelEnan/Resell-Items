import 'dart:convert';

import 'package:backend_flutter/constants.dart';
import 'package:backend_flutter/models/model.dart';

import 'package:http/http.dart' as http;

class InputService {
  Constants constants = Constants();
  Future<List<Employees>> postApi(
      String id, String image, String title, String content, String price) async {
    String url = constants.empInput;

    Map<String, dynamic> param = {
      "userId": id,
      "image": image,
      "title": title,
      "content": content,
      "price" : price,
    };

    Uri uri = Uri.parse(url);
    // final finalUri = uri.replace(queryParameters: qParams);

    final response = await http.post(
      uri,
      headers: {"Content-type": "application/json; charset=UTF-8"},
      body: jsonEncode(param),
    );
    print(url);

    if (response.statusCode == 200) {
      print(response.statusCode);
      final resp = '[${response.body}]';
      // final resp = response.body;
      print(resp);
      // Map<String, dynamic> services =
      //     Map<String, dynamic>.from((jsonDecode(resp)));

      // return Employees.fromJson(jsonDecode(resp));
      List service = jsonDecode(resp);

      return service.map((json) => Employees.fromJson(json)).toList();

      // return TwitterModel.fromJson(jsonDecode(resp));
      //
    } else {
      throw Exception('${response.statusCode}');
    }
  }
}
