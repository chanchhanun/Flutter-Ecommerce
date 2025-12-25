import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../constants/app_const.dart';
import '../../models/product.model.dart';
import 'dart:developer' as dev;

class ProductApi {
  Future<List<Product>> fetchProduct() async {
    try {
      final url = Uri.parse('${AppConst.baseUrl}/products');
      final res = await http.get(url);
      if (res.statusCode == 200) {
        List data = jsonDecode(res.body)['products'];
        dev.log('data of all products : $data');
        return data.map((e) => Product.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  // filter product by category id
  Future<List<Product>> fetchProductByCategoryId(String id) async {
    try {
      final url = Uri.parse('${AppConst.baseUrl}/products?category=$id');
      final res = await http.get(url);
      if (res.statusCode == 200) {
        List data = jsonDecode(res.body)['products'];
        dev.log('data products by category : $data');
        return data.map((e) => Product.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  // fetch product best exclusive
  Future<List<Product>> fetchProductExclusive() async {
    try {
      final url = Uri.parse('${AppConst.baseUrl}/products?sort=exclusive');
      final res = await http.get(url);
      if (res.statusCode == 200) {
        List data = jsonDecode(res.body)['products'];
        return data.map((e) => Product.fromJson(e)).toList();
      } else {
        dev.log('else : ${res.body}');
        return [];
      }
    } catch (e) {
      dev.log('catch e : $e');
      return [];
    }
  }

  // fetch product best selling
  Future<List<Product>> fetchProductBestSelling() async {
    try {
      final url = Uri.parse('${AppConst.baseUrl}/products?sort=best_selling');
      final res = await http.get(url);
      if (res.statusCode == 200) {
        List data = jsonDecode(res.body)['products'];
        return data.map((e) => Product.fromJson(e)).toList();
      } else {
        dev.log('else : ${res.body}');
        return [];
      }
    } catch (e) {
      dev.log('catch e : $e');
      return [];
    }
  }

  // fetch product best selling
  Future<List<Product>> fetchProductNewest() async {
    try {
      final url = Uri.parse('${AppConst.baseUrl}/products?sort=newest');
      final res = await http.get(url);
      if (res.statusCode == 200) {
        List data = jsonDecode(res.body)['products'];
        return data.map((e) => Product.fromJson(e)).toList();
      } else {
        dev.log('else : ${res.body}');
        return [];
      }
    } catch (e) {
      dev.log('catch e : $e');
      return [];
    }
  }

  // fetch single product
  Future<Product> fetchSingleProduct({required String productId}) async {
    try {
      final url = Uri.parse('${AppConst.baseUrl}/products/$productId');
      final res = await http.get(url);
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body)['product'] as Map<String, dynamic>;
        return Product.fromJson(data);
      } else {
        return Product();
      }
    } catch (e) {
      dev.log('error fetching single product : $e');
      return Product();
    }
  }

  // search suggesttion
  Future<List<Product>> searchSuggestion({required String productName}) async {
    try {
      final url = Uri.parse(
        '${AppConst.baseUrl}/products?search=$productName&autocomplete=true',
      );
      final res = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body)['suggestions'] as List<dynamic>;
        return data.map((e) => Product.fromJson(e)).toList();
      } else {
        dev.log('else : ${res.body}');
        return [];
      }
    } catch (e) {
      dev.log('error : $e');
      return [];
    }
  }
}
