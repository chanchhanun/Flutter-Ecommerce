import 'package:get/get.dart';
import 'package:grocery_app/services/apis/auth_api.dart';

class AuthController extends GetxController {
  final _authApi = AuthApi();
  var isLoading = false.obs;
  Future<void> login(String email, String password) async {
    isLoading(true);
    await _authApi.login(email, password);
    isLoading(false);
  }

  Future<void> register(String username, String email, String password) async {
    isLoading(true);
    await _authApi.register(username, email, password);
    isLoading(false);
  }
}
