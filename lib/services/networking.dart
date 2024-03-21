import 'dart:convert';

import 'package:http/http.dart';

class NetworkHelper {
  NetworkHelper(this.url);
  final String url;

  Future getData() async {
    Uri parsedUrl = Uri.parse(url);

    Response response = await get(parsedUrl);
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
