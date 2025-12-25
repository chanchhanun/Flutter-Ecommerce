import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/constants/AppColor.dart';
import 'package:grocery_app/screen/account_page.dart';
import 'package:grocery_app/screen/cart_page.dart';
import 'package:grocery_app/screen/explore_page.dart';
import 'package:grocery_app/screen/favorite_page.dart';
import 'package:grocery_app/screen/shop_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  dynamic iconPath = 'assets/icons/';
  int selectedIndex = 0;
  final List<Widget> _pages = [
    ShopPage(),
    ExplorePage(),
    CartPage(),
    FavoritePage(),
    AccountPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[selectedIndex],
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(8.0),
        color: Colors.white,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: primary,
            unselectedItemColor: Colors.black,
            currentIndex: selectedIndex,
            onTap: (value) {
              setState(() {
                selectedIndex = value;
              });
            },
            items: [
              BottomNavigationBarItem(
                label: 'Shop',
                backgroundColor: primary,
                icon: SvgPicture.asset(
                  iconPath + 'shop_icon.svg',
                  color: selectedIndex == 0 ? primary : Colors.black,
                ),
              ),
              BottomNavigationBarItem(
                label: 'Explore',
                icon: SvgPicture.asset(
                  iconPath + 'explore_icon.svg',
                  color: selectedIndex == 1 ? primary : Colors.black,
                ),
              ),
              BottomNavigationBarItem(
                label: 'Cart',
                icon: SvgPicture.asset(
                  iconPath + 'cart_icon.svg',
                  color: selectedIndex == 2 ? primary : Colors.black,
                ),
              ),
              BottomNavigationBarItem(
                label: 'Favorite',
                icon: SvgPicture.asset(
                  iconPath + 'favourite_icon.svg',
                  color: selectedIndex == 3 ? primary : Colors.black,
                ),
              ),
              BottomNavigationBarItem(
                label: 'Account',
                icon: SvgPicture.asset(
                  iconPath + 'account_icon.svg',
                  color: selectedIndex == 4 ? primary : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
