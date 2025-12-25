import 'dart:convert';

import 'package:grocery_app/constants/app_const.dart';
import 'package:grocery_app/models/user.model.dart';
import 'package:grocery_app/services/storages/token_storage.dart';
import 'dart:developer' as dev;
import 'package:http/http.dart' as http;

class UserApi {
  // fetch user
  Future<User> fetchUser() async {
    try {
      final url = Uri.parse('${AppConst.baseUrl}/users/profile');
      final token = await TokenStorage().getToken();
      final res = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (res.statusCode == 200) {
        final userJson = jsonDecode(res.body);
        return User.fromJson(userJson);
      } else {
        dev.log('${res.body}');
        return User.empty();
      }
    } catch (e) {
      dev.log('error : $e');
      return User.empty();
    }
  }
}
