import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sociallogin/model/model.dart';

class LoginController {
  final productlist = <BeerModel>[].obs;

  Future<List<BeerModel>> fetchPosts() async {
    final response =
        await http.get(Uri.parse('https://api.punkapi.com/v2/beers'));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      final list = (data as List<dynamic>)
          .map((e) => BeerModel.fromJson((e as Map<String, dynamic>)))
          .toList();

      productlist.clear();
      productlist.addAll(list);

      return list;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
