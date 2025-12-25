import 'package:get/get.dart';
import 'package:grocery_app/models/user.model.dart';
import 'package:grocery_app/services/apis/user_api.dart';

class UserController extends GetxController {
  final _userApi = UserApi();
  var user = User.empty().obs;

  @override
  void onInit() {
    super.onInit();
    fetchUser();
  }

  // get user
  Future<void> fetchUser() async {
    final data = await _userApi.fetchUser();
    user.value = data;
  }
}
