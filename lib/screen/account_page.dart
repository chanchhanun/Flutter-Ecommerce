import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/constants/AppColor.dart';
import 'package:grocery_app/controllers/user_controller.dart';
import 'package:grocery_app/screen/login_page.dart';
import 'package:grocery_app/services/storages/token_storage.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  AccountPage({super.key});

  final String profilePath = 'assets/images/profile.jpg';

  final List<Map<String, String>> accountItems = [
    {'icon': 'assets/icons/account_icons/orders_icon.svg', 'title': 'Orders'},
    {
      'icon': 'assets/icons/account_icons/details_icon.svg',
      'title': 'My Details',
    },
    {
      'icon': 'assets/icons/account_icons/delivery_icon.svg',
      'title': 'Delivery Address',
    },
    {
      'icon': 'assets/icons/account_icons/payment_icon.svg',
      'title': 'Payment Methods',
    },
    {
      'icon': 'assets/icons/account_icons/promo_icon.svg',
      'title': 'Promo Code',
    },
    {
      'icon': 'assets/icons/account_icons/notification_icon.svg',
      'title': 'Notification',
    },
    {'icon': 'assets/icons/account_icons/help_icon.svg', 'title': 'Help'},
    {'icon': 'assets/icons/account_icons/about_icon.svg', 'title': 'About'},
  ];

  final _tokenStorage = TokenStorage();
  final userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SingleChildScrollView(
              child: Column(
                spacing: 10,
                children: [
                  Row(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(profilePath),
                        radius: 36,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            spacing: 10,
                            children: [
                              Text(
                                userController.user.value.fullName.toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Icon(Icons.edit_outlined, color: primary),
                            ],
                          ),
                          Text(
                            userController.user.value.email.toString(),
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(),
                  ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var item = accountItems[index];
                      return ListTile(
                        leading: SvgPicture.asset(item['icon']!),
                        title: Text(item['title']!),
                        trailing: Icon(Icons.arrow_forward_ios),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: accountItems.length,
                  ),
                  Divider(),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        await _tokenStorage.clearToken();
                        Get.off(LoginPage());
                      },
                      style: ElevatedButton.styleFrom(
                        visualDensity: VisualDensity.compact,
                        backgroundColor: grayLight,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: SvgPicture.asset(
                        'assets/icons/account_icons/logout_icon.svg',
                      ),
                      iconAlignment: IconAlignment.start,
                      label: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          'Log Out',
                          style: TextStyle(
                            color: primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
