import 'package:flutter/material.dart';
import 'package:grocery_app/controllers/product_controller.dart';
import 'package:grocery_app/widgets/card_item_widget.dart';
import 'package:get/get.dart';

class SearchSortPage extends StatelessWidget {
  SearchSortPage({super.key});

  final searchController = TextEditingController();

  final productController = Get.put(ProductController());

  late final products = productController.productList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) {
            productController.onSearh(value);
          },
          controller: searchController,
          decoration: InputDecoration(
            filled: true,
            hintText: 'Search',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(borderSide: BorderSide.none),
            suffixIcon: searchController.text.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      searchController.clear();
                    },
                    icon: Icon(Icons.close),
                  )
                : null,
          ),
        ),
        actions: [Icon(Icons.sort), SizedBox(width: 10)],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Obx(() {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: .8,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            ),
            itemCount: productController.filterProducts.length,
            itemBuilder: (context, index) {
              var item = productController.filterProducts[index];
              return CardItemWidget(item: item);
            },
          );
        }),
      ),
    );
  }
}
