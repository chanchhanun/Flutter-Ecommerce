import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_app/constants/AppColor.dart';
import 'package:grocery_app/controllers/product_controller.dart';
import 'package:grocery_app/models/product.model.dart';
import 'package:grocery_app/services/apis/product_api.dart';
import 'package:grocery_app/widgets/card_item_widget.dart';
import 'package:grocery_app/widgets/loading-widget/loading_banner.dart';
import 'package:grocery_app/widgets/loading-widget/loading_cart.dart';
import 'package:grocery_app/widgets/loading-widget/loading_header.dart';
import 'package:grocery_app/widgets/search_widget.dart';
import 'package:get/get.dart';

class ShopPage extends StatelessWidget {
  ShopPage({super.key});

  final productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SingleChildScrollView(
            child: Obx(
              () => Column(
                children: [
                  SvgPicture.asset('assets/icons/app_icon_color.svg'),
                  _locationWidget(),
                  SearchWidget(),
                  productController.isLoading.value == true
                      ? LoadingBanner()
                      : _slideableBannerWidget(),
                  productController.isLoading.value == true
                      ? LoadingHeader()
                      : _headerExclusiveWidget(title: 'Exclusive Offer'),
                  productController.isLoading.value == true
                      ? LoadingCart()
                      : _itemExclusiveWidget(
                          products: productController.productList,
                        ),
                  productController.isLoading.value == true
                      ? LoadingHeader()
                      : _headerExclusiveWidget(title: 'Best Selling'),
                  productController.isLoading.value == true
                      ? LoadingCart()
                      : _itemExclusiveWidget(
                          products: productController.productExclusive,
                        ),
                  productController.isLoading.value == true
                      ? LoadingHeader()
                      : _headerExclusiveWidget(title: 'Groceries'),
                  _itemGroceryWidget(),
                  // just replace with discount
                  productController.isLoading.value == true
                      ? LoadingHeader()
                      : _headerExclusiveWidget(title: 'Discount'),
                  productController.isLoading.value == true
                      ? LoadingCart()
                      : _itemExclusiveWidget(
                          products: productController.productNewest,
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _itemGroceryWidget() {
    return Container(
      width: double.infinity,
      height: 120,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            width: 280,
            height: double.infinity,
            decoration: BoxDecoration(
              color: yellow.withOpacity(.3),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.all(10.0),
            child: Row(
              spacing: 20,
              children: [
                Image.asset('assets/images/pulses.png'),
                Text(
                  'Pulses',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(width: 20),
        itemCount: 5,
      ),
    );
  }

  Widget _itemExclusiveWidget({required List<Product> products}) {
    return Container(
      width: double.infinity,
      height: 260,
      margin: EdgeInsets.symmetric(vertical: 12),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var item = products[index];
          return CardItemWidget(item: item);
        },
        separatorBuilder: (context, index) => SizedBox(width: 16),
        itemCount: products.length,
      ),
    );
  }

  Widget _headerExclusiveWidget({required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          Text(
            'See all',
            style: TextStyle(
              color: primaryDark,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _slideableBannerWidget() {
    return Container(
      width: double.infinity,
      height: 150,
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage('assets/images/banner_background.png'),
        ),
      ),
      child: Row(
        spacing: 12,
        children: [
          Image.asset(
            'assets/images/categories_images/fruit.png',
            fit: BoxFit.cover,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Fresh Vegetable',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              Text(
                'Get Up to 40% OFF',
                style: TextStyle(
                  color: primary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _locationWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/location_icon.svg',
            width: 20,
            color: Colors.black,
          ),
          SizedBox(width: 12),
          Text(
            'Tual Kok, Phnom Penh',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
