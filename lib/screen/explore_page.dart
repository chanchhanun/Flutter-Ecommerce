import 'package:flutter/material.dart';
import 'package:grocery_app/controllers/category_controller.dart';
import 'package:grocery_app/controllers/product_controller.dart';
import 'package:grocery_app/screen/category_item_page.dart';
import 'package:grocery_app/widgets/card_item_widget.dart';
import 'package:grocery_app/widgets/loading-widget/loading_image.dart';
import 'package:grocery_app/widgets/search_widget.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ExplorePage extends StatelessWidget {
  ExplorePage({super.key});
  final categoryController = Get.put(CategoryController());
  final productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Find Products',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SingleChildScrollView(
            child: Column(
              spacing: 12,
              children: [
                SearchWidget(),
                _buildCategoriesSection(),
                _buildNewestSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNewestSection() {
    return Column(
      children: [
        _buildHeader(title: 'New Arrivals'),
        Container(
          width: double.infinity,
          height: 260,
          margin: EdgeInsets.symmetric(vertical: 12),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              var item = productController.productNewest[index];
              return CardItemWidget(item: item);
            },
            separatorBuilder: (context, index) => SizedBox(width: 6),
            itemCount: productController.productNewest.length,
          ),
        ),
      ],
    );
  }

  Widget _buildHeader({required String title, bool isCategoried = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        isCategoried
            ? Text(
                'See All',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              )
            : SizedBox.shrink(),
      ],
    );
  }

  Widget _buildCategoriesSection() {
    return Column(
      spacing: 16,
      children: [
        _buildHeader(title: 'Show All Categories', isCategoried: true),
        GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: .9,
          ),
          itemCount: categoryController.categoryList.length,
          itemBuilder: (context, index) {
            var item = categoryController.categoryList[index];
            var categoryId = categoryController.categoryList[index].id!;
            return GestureDetector(
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryItemPage(
                      categoryName: item.name!,
                      categoryId: categoryId,
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CachedNetworkImage(
                      imageUrl: item.image.toString(),
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child: LoadingImage(
                          height: 120,
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
                    SizedBox(height: 6),
                    Expanded(
                      child: categoryController.isLoading.value == true
                          ? LoadingImage(
                              height: 30,
                              color: Colors.grey.shade200,
                            )
                          : Text(
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              item.name.toString(),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
