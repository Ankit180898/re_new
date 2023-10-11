import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Controllers/internet_controller.dart';

class ApiService {

  final InternetController _internetController = Get.find<InternetController>();

  Future<dynamic> get(String url, {Map<String, String>? headers}) async {
    if (!_internetController.isConnected) {
      throw Exception('No internet connection.');
    }
    else {
      try {
        final response = await http.get(Uri.parse(url), headers: headers);
        if (response.statusCode == 200) {
          return json.decode(response.body);
        } else {
          throw Exception('Failed to load data: ${response.statusCode}');
        }
      } catch (e) {
        throw Exception('Failed to load data: $e');
      }
    }
  }
  Future<dynamic> post(String url, Map<String, String> headers, Map<String, String> body) async {
    if (!_internetController.isConnected) {
      throw Exception('No internet connection.');
    }
    else {
      try {
        final response = await http.post(Uri.parse(url), headers: headers,body:json.encode(body) );
        if (response.statusCode == 200) {
          return json.decode(response.body);
        } else {
          throw Exception('Failed to load data: ${json.decode(response.body)['message']}');
        }
      } catch (e) {
        throw Exception('Failed to load data: $e');
      }
    }
  }

}