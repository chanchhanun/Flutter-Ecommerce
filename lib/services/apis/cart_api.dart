import 'dart:convert';

import 'package:grocery_app/constants/app_const.dart';
import 'package:grocery_app/services/storages/token_storage.dart';
import 'package:grocery_app/utils/snack_bar_util.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;

import '../../models/cart.model.dart';

class CartApi {
  final tokenStorage = TokenStorage();
  // create cart
  Future<void> createCart(String productId) async {
    try {
      final url = Uri.parse('${AppConst.baseUrl}/carts/');
      final token = await tokenStorage.getToken();
      final res = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'productId': productId}),
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        SnackBarUtil.showSnackBar(isError: false);
      } else {
        var message = jsonDecode(res.body)['message'];
        SnackBarUtil.showSnackBar(isError: true, message: message);
      }
    } catch (e) {
      print(tokenStorage.getToken());
    }
  }

  // user get cart
  Future<Cart> fetchCart() async {
    try {
      final url = Uri.parse('${AppConst.baseUrl}/carts/');
      final token = await tokenStorage.getToken();
      final res = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        return Cart.fromJson(data);
      } else {
        dev.log('cart res : ${res.body}');
        return Cart.empty();
      }
    } catch (e) {
      dev.log('user get cart catch : $e');
      return Cart.empty();
    }
  }

  // update item quantity
  Future<void> updateItemQuantity({
    required String productId,
    required int quantity,
  }) async {
    try {
      final url = Uri.parse('${AppConst.baseUrl}/carts/items/$productId');
      final token = await tokenStorage.getToken();
      final res = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'quantity': quantity}),
      );
      if (res.statusCode == 200) {
        dev.log('cart item update : ${res.body}');
      } else {
        SnackBarUtil.showSnackBar(isError: true);
      }
    } catch (e) {
      dev.log('error update item qty : $e');
    }
  }

  Future<void> removeCartItem({required String productId}) async {
    try {
      final url = Uri.parse('${AppConst.baseUrl}/carts/items/$productId');
      final token = await tokenStorage.getToken();
      final res = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (res.statusCode == 200) {
        dev.log(res.body);
      } else {
        dev.log('ealse : ${res.body}');
      }
    } catch (e) {
      dev.log('error remove cart : $e');
    }
  }
}
