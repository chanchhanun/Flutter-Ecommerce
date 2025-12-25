import 'package:flutter/material.dart';
import 'package:grocery_app/constants/AppColor.dart';
import 'package:grocery_app/controllers/cart_controller.dart';
import 'package:grocery_app/screen/checkout_page.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:grocery_app/screen/product_detail.dart';
import 'package:grocery_app/widgets/loading-widget/loading_image.dart';

class CartPage extends StatefulWidget {
  CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'My Cart',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: Obx(() {
        final items = cartController.cart.value.items;
        return items!.isEmpty
            ? Center(child: Text('Cart is empty'))
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Divider(),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: items.length,
                      separatorBuilder: (context, index) => Divider(),
                      itemBuilder: (context, index) {
                        var item = items[index];
                        var totalPrice =
                            (item.quantity!) * (item.product!.price ?? 0.0);
                        return GestureDetector(
                          onTap: () {
                            Get.to(
                              () => ProductDetail(
                                productId: item.product!.id.toString(),
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: 180,
                            color: Colors.white,
                            padding: EdgeInsets.all(14.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: item.product!.images![0].toString(),
                                  height: 120,
                                  width: 120,
                                  errorWidget: (context, url, error) => Center(
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
                                SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 200,
                                            child: Text(
                                              item.product!.name ?? '',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              cartController.removeCartItem(
                                                productId: item.product!.id
                                                    .toString(),
                                              );
                                            },
                                            icon: Icon(Icons.close),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '${item.product!.unit}, Price',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(height: 12),
                                      Row(
                                        spacing: 16,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              cartController.updateItemQuantity(
                                                productId: item.product!.id
                                                    .toString(),
                                                quantity: -1,
                                              );
                                            },
                                            style: IconButton.styleFrom(
                                              side: BorderSide(
                                                color: Colors.grey,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                            icon: Icon(
                                              Icons.remove,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            '${item.quantity}',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              cartController.updateItemQuantity(
                                                productId: item.product!.id
                                                    .toString(),
                                                quantity: 1,
                                              );
                                            },
                                            style: IconButton.styleFrom(
                                              side: BorderSide(
                                                color: Colors.grey,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                            icon: Icon(
                                              Icons.add,
                                              color: primaryDark,
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            '\$${totalPrice.toStringAsFixed(2)}',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
      }),
      bottomSheet: Container(
        width: double.infinity,
        height: 60,
        margin: EdgeInsets.all(8.0),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          icon: Container(
            padding: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: primaryDark,
            ),
            child: Text(
              '\$28.48',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          iconAlignment: IconAlignment.end,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CheckoutPage()),
            );
          },
          label: Text(
            'Go to Checkout',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
