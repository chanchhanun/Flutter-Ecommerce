import 'dart:convert';

import 'package:grocery_app/constants/app_const.dart';
import 'package:grocery_app/models/wishlist.model.dart';
import 'package:grocery_app/services/storages/token_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;

class WishlistApi {
  // create wishlist
  Future<void> createWishlist({required String productId}) async {
    try {
      final url = Uri.parse('${AppConst.baseUrl}/wishlists');
      final token = await TokenStorage().getToken();
      final res = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'productId': productId}),
      );
      if (res.statusCode == 201) {
        dev.log(res.body);
      } else {
        dev.log('else : ${res.body}');
      }
    } catch (e) {
      dev.log('error wishlist :$e');
    }
  }

  // fetch wishlist
  Future<Wishlist> fetchWishlist() async {
    try {
      final url = Uri.parse('${AppConst.baseUrl}/wishlists');
      final token = await TokenStorage().getToken();
      final res = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (res.statusCode == 200) {
        Map<String, dynamic> dataJson = jsonDecode(res.body);
        dev.log(res.body);
        return Wishlist.fromJson(dataJson);
      } else {
        dev.log('else fetchWishlist:${res.body}');
        return Wishlist.empty();
      }
    } catch (e) {
      dev.log('error fetching wishlist :$e');
      return Wishlist.empty();
    }
  }

  // remove a product from wishlist
  Future<bool> isRemoveProductFromWishlist({required String productId}) async {
    try {
      final url = Uri.parse('${AppConst.baseUrl}/wishlists/$productId');
      final token = await TokenStorage().getToken();
      final res = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (res.statusCode == 200) {
        dev.log(res.body);
        return true;
      } else {
        dev.log(res.body);
        return false;
      }
    } catch (e) {
      print('is remove :$e');
      return false;
    }
  }

  // product is in wishlist
  Future<bool> isInWishlist({required String productId}) async {
    try {
      final url = Uri.parse(
        '${AppConst.baseUrl}/wishlists/is-in-wishlist/$productId',
      );
      final token = await TokenStorage().getToken();
      final res = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (res.statusCode == 200) {
        dev.log(res.body);
        return true;
      } else {
        dev.log(res.body);
        return false;
      }
    } catch (e) {
      print('is remove :$e');
      return false;
    }
  }
}
