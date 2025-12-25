import 'dart:convert';
import 'dart:math';

import 'package:grocery_app/constants/app_const.dart';
import 'package:http/http.dart' as http;
import '../../models/category.model.dart';

class CategoryApi {
  // fetch api
  Future<List<Category>> fetchCategories() async {
    try {
      final url = Uri.parse('${AppConst.baseUrl}/categories');
      final res = await http.get(url);
      if (res.statusCode == 200) {
        List data = jsonDecode(res.body);
        return data.map((e) => Category.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
