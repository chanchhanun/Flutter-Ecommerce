import 'package:flutter/material.dart';
import 'package:grocery_app/constants/AppColor.dart';
import 'package:grocery_app/screen/account_page.dart';
import 'package:grocery_app/screen/cart_page.dart';
import 'package:grocery_app/screen/explore_page.dart';
import 'package:grocery_app/screen/favorite_page.dart';
import 'package:grocery_app/screen/login_page.dart';
import 'package:grocery_app/screen/main_page.dart';
import 'package:grocery_app/screen/shop_page.dart';
import 'package:get/get.dart';
import 'package:grocery_app/screen/sign_up_page.dart';
import 'package:grocery_app/screen/welcome_page.dart';
import 'package:grocery_app/services/storages/token_storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final tokenStorage = TokenStorage();
  // keep user login with token
  void keepUserLogined() async {
    final token = await tokenStorage.getToken();
    if (token != null) {
      Get.off(MainPage());
    } else {
      Get.off(LoginPage());
    }
  }

  @override
  void initState() {
    super.initState();
    keepUserLogined();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: CircularProgressIndicator()),
      theme: ThemeData(
        fontFamily: 'Gilroy',
        inputDecorationTheme: InputDecorationThemeData(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: yellow),
          ),
          border: UnderlineInputBorder(borderSide: BorderSide(color: gray)),
        ),
      ),
      getPages: [
        GetPage(name: '/shop', page: () => ShopPage()),
        GetPage(name: '/explore', page: () => ExplorePage()),
        GetPage(name: '/cart', page: () => CartPage()),
        GetPage(name: '/favorite', page: () => FavoritePage()),
        GetPage(name: '/account', page: () => AccountPage()),
        GetPage(name: '/welcome', page: () => WelcomePage()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/signup', page: () => SignUpPage()),
      ],
    );
  }
}
