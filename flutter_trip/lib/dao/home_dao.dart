import 'package:fluttertrip/model/home_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

const HOME_URL = 'https://www.devio.org/io/flutter_app/json/home_page.json';

class HomeDao {
  static Future<HomeModel> fetch() async {
    final response = await http.get(HOME_URL);
    //请求成功
    if (response.statusCode == 200) {
      //修复中文乱码
      Utf8Decoder utf8Decoder = Utf8Decoder();
      var result = json.decode(utf8Decoder.convert(response.bodyBytes));
      return HomeModel.fromJson(result);
    } else {
      throw Exception('Failed to load home_page.json');
    }
  }
}
