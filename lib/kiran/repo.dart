import 'dart:convert';
import 'package:foodapp/constants/strings.dart';
import 'package:foodapp/kiran/models.dart';
import 'package:http/http.dart';

class ProductPageRepo {
  Future<List<Foodly>> call(String endpoint) async {
    Response response = await get(
        'https://thefoodly.com/wp-json/wc/v3/$endpoint?consumer_key=$consumerKey&consumer_secret=$consumerSecret');
    var data = jsonDecode(response.body);
    List<Foodly> products = [];
    for (int i = 0; i < data.length; i++) {
      Foodly prod = Foodly.fromJson(data[i]);
      products.add(prod);
    }
    return products;
  }
}
