import 'package:http/http.dart';
import 'dart:convert';

class NetworkHelper {
  // static String baseUrl = 'http://neutrinonda.pythonanywhere.com/api/';
  static String baseUrl = 'https://64f0-2401-4900-1c3d-1220-101e-3423-58f7-70a5.in.ngrok.io/api/';

  Future<Response> getData({required String url}) async {
    final response = await get(
      Uri.parse(baseUrl + url),
    ).timeout(const Duration(seconds: 60));
    return response;
  }

  Future<Response> postData(
      {required String url, required Map<String, dynamic> jsonMap}) async {
    String jsonString = json.encode(jsonMap);
    final response = await post(
      Uri.parse(baseUrl + url),
      headers: {'Content-Type': 'application/json', 'Vary': 'Accept'},
      body: jsonString,
    ).timeout(const Duration(seconds: 60));
    return response;
  }
}
