import 'package:flutter/material.dart';
import 'package:grocery_app/constants/AppColor.dart';
import 'package:grocery_app/controllers/cart_controller.dart';
import 'package:grocery_app/controllers/product_controller.dart';
import 'package:grocery_app/controllers/wishlist_controller.dart';
import 'package:grocery_app/models/product.model.dart';
import 'package:grocery_app/widgets/loading-widget/loading_image.dart';

import '../widgets/custom_button_widget.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductDetail extends StatefulWidget {
  final String productId;
  ProductDetail({super.key, required this.productId});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final productController = Get.put(ProductController());
  final wishlistController = Get.put(WishlistController());
  final cartController = Get.put(CartController());

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await productController.fetchSingleProduct(productId: widget.productId);
      // wishlistController.isInWishlist(productId: widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        actions: [Icon(Icons.download_done), SizedBox(width: 12)],
      ),
      body: Obx(() {
        var product = productController.singleProduct.value;
        bool isFav = wishlistController.isInWishlist(product.id.toString());
        return productController.isLoadingSingleProduct.value
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(18),
                          bottomLeft: Radius.circular(18),
                        ),
                      ),
                      height: MediaQuery.of(context).size.height * .3,
                      child: CachedNetworkImage(
                        imageUrl: product.images?.first ?? '',
                        placeholder: (context, url) => Center(
                          child: LoadingImage(
                            height: MediaQuery.of(context).size.height * .3,
                            color: Colors.grey.shade200,
                          ),
                        ),
                        errorWidget: (context, url, error) => Center(
                          child: Text(
                            'ImageUrl not found.',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      child: Column(
                        spacing: 10,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 320,
                                child: Text(
                                  product.name ?? '',
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 26,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () =>
                                    wishlistController.toggleWishlist(
                                      productId: product.id.toString(),
                                    ),
                                icon: Icon(
                                  isFav
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isFav ? Colors.red : Colors.black,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '${product.description}, Price',
                            style: TextStyle(
                              color: grayDark,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                spacing: 12,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      if (productController.quantity > 1) {
                                        productController.quantity--;
                                      }
                                    },
                                    icon: Icon(Icons.remove),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: gray),
                                    ),
                                    child: Text(
                                      '${productController.quantity}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      productController.quantity++;
                                    },
                                    icon: Icon(Icons.add, color: primaryDark),
                                  ),
                                ],
                              ),
                              Text(
                                '\$${product.price}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          ExpansionTile(
                            expandedAlignment: Alignment.topLeft,
                            title: Text(
                              'Product Detail',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text(
                                  '${product.description}',
                                  style: TextStyle(
                                    color: grayDark,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ListTile(
                            leading: Text(
                              'Nutrition\'s',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            title: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.0),
                                  color: grayLight,
                                ),
                                padding: EdgeInsets.all(6.0),
                                child: Text(
                                  '100gr',
                                  style: TextStyle(
                                    color: grayDark,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios, size: 18),
                          ),
                          Divider(),
                          ListTile(
                            leading: Text(
                              'Review',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            title: Align(
                              alignment: Alignment.centerRight,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: List.generate(
                                  5,
                                  (index) =>
                                      Icon(Icons.star, color: Colors.orange),
                                ),
                              ),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios, size: 18),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        child: CustomButtonWidget(
          title: 'Add to Basket',
          onPressed: () async {
            await cartController.createCart(widget.productId.toString());
            await cartController.updateItemQuantity(
              productId: widget.productId.toString(),
              quantity: productController.quantity.toInt() - 1,
            );
            productController.quantity = 1.obs;
          },
        ),
      ),
    );
  }
}
