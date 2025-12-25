import 'dart:math';

import 'package:flutter/material.dart';
import 'package:grocery_app/constants/AppColor.dart';
import 'package:grocery_app/controllers/wishlist_controller.dart';
import 'package:grocery_app/screen/product_detail.dart';
import 'package:grocery_app/utils/snack_bar_util.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../widgets/loading-widget/loading_image.dart';

class FavoritePage extends StatelessWidget {
  FavoritePage({super.key});

  final wishlistController = Get.put(WishlistController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Favorite',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Obx(() {
        return wishlistController.wishlist.value.items!.isEmpty
            ? Center(child: Text('Wishlist is empty'))
            : Column(
                children: [
                  Divider(),
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var item =
                            wishlistController.wishlist.value.items![index];
                        return Slidable(
                          endActionPane: ActionPane(
                            motion: ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  wishlistController.removeProductFromWishlist(
                                    productId: item.product!.id.toString(),
                                  );
                                },
                                flex: 1,
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                icon: Icons.remove,
                                label: 'Remove',
                              ),
                            ],
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Get.to(
                                () => ProductDetail(
                                  productId: item.product!.id.toString(),
                                ),
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              height: 160,
                              padding: EdgeInsets.all(18.0),
                              child: Row(
                                spacing: 20,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: item.product!.images![0]
                                        .toString(),
                                    width: 100,
                                    height: 100,
                                    errorWidget: (context, url, error) =>
                                        Center(
                                          child: Text(
                                            'ImageUrl not found.',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                    placeholder: (context, url) => Center(
                                      child: LoadingImage(
                                        height: 100,
                                        color: Colors.grey.shade200,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.product!.name ?? '',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          item.product!.unit ?? '',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    spacing: 10,
                                    children: [
                                      Text(
                                        '\$${item.product!.price!.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Icon(Icons.arrow_forward_ios),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(),
                      itemCount:
                          wishlistController.wishlist.value.items!.length,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    margin: EdgeInsets.all(12.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        SnackBarUtil.showSnackBar(isError: false);
                      },
                      child: Text(
                        'Add All to Cart',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              );
      }),
    );
  }
}
