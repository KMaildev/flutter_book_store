import 'dart:convert';

import 'package:book_store/model/exchange_rate.dart';
import 'package:book_store/model/post.dart';
import 'package:book_store/model/rate.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  static String _link = 'forex.cbm.gov.mm';
  static String _route_latest = '/api/latest';

  static String _api_link = 'jsonplaceholder.typicode.com';
  static String _route_post = '/posts';

  static Future<ExchangeRate> getAllData() async {
    var url = Uri.https(_link, _route_latest);
    var response = await http.get(url);
    return exchangeRateFromJson(response.body);
  }

  static Future<List<Post>> getAllPost() async {
    var url = Uri.https(_api_link, _route_post);
    var response = await http.get(url);
    return postFromJson(response.body);
  }

  static Future postData(Post post) async {
    var url = Uri.https(_api_link, _route_post);
    var response = await http.post(url,
        headers: {'Content-type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          'userId': post.userId,
          'title': post.title,
          'body': post.body,
        }));
    print(response.body);
  }
}
