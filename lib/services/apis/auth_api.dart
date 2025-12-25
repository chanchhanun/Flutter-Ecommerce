import 'dart:convert';

import 'package:get/get.dart';
import 'package:grocery_app/constants/app_const.dart';
import 'package:grocery_app/screen/main_page.dart';
import 'package:grocery_app/services/storages/token_storage.dart';
import 'package:grocery_app/utils/header_util.dart';
import 'package:grocery_app/utils/snack_bar_util.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class AuthApi {
  final tokenStorage = TokenStorage();
  Future<void> login(String email, String password) async {
    try {
      final url = Uri.parse('${AppConst.baseUrl}/users/login');
      final res = await http.post(
        url,
        headers: HeaderUtil.header,
        body: jsonEncode({'email': email, 'password': password}),
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        final token = jsonDecode(res.body)['token'];
        developer.log('token : $token');
        await tokenStorage.setToken(token);
        Get.off(MainPage());
        SnackBarUtil.showSnackBar(isError: false);
      } else {
        // forget password dev
        var incorrect = jsonDecode(res.body)['message'];
        SnackBarUtil.showSnackBar(isError: true, message: '$incorrect');
        developer.log('body : $incorrect');
      }
    } catch (e) {
      developer.log('error : $e');
    }
  }

  Future<void> register(String fullName, String email, String password) async {
    try {
      final url = Uri.parse('${AppConst.baseUrl}/users/register/');
      final res = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'fullName': fullName,
          'email': email,
          'password': password,
        }),
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        final user = jsonDecode(res.body);
        final token = user['token'];
        developer.log('user : $user');
        await tokenStorage.setToken(token);
        Get.to(MainPage());
      } else {
        developer.log('body : ${res.body}');
      }
    } catch (e) {
      developer.log('error : $e');
    }
  }
}
