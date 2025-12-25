import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/controllers/cart_controller.dart';
import 'package:grocery_app/controllers/wishlist_controller.dart';
import 'package:grocery_app/screen/product_detail.dart';
import 'package:grocery_app/widgets/loading-widget/loading_image.dart';

import '../constants/AppColor.dart';
import '../models/product.model.dart';

class CardItemWidget extends StatelessWidget {
  final Product item;
  CardItemWidget({super.key, required this.item});
  final cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetail(productId: item.id.toString()),
          ),
        );
      },
      child: Container(
        width: 180,
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: gray),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: item.images![0].toString(),
              width: double.infinity,
              height: 100,
              errorWidget: (context, url, error) => Center(
                child: Text(
                  'ImageUrl not found.',
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
              placeholder: (context, url) => Center(
                child: LoadingImage(height: 100, color: Colors.grey.shade200),
              ),
            ),
            SizedBox(height: 12),
            Text(
              item.name ?? '',
              maxLines: 2,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${item.price}',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await cartController.createCart(item.id.toString());
                  },
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.all(12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  icon: Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
