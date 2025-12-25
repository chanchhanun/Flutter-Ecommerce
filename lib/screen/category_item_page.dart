import 'package:flutter/material.dart';
import 'package:grocery_app/controllers/product_controller.dart';
import 'package:grocery_app/screen/filter_page.dart';
import 'package:grocery_app/widgets/card_item_widget.dart';
import 'package:get/get.dart';

class CategoryItemPage extends StatefulWidget {
  final String categoryName;
  final String categoryId;
  CategoryItemPage({
    super.key,
    required this.categoryName,
    required this.categoryId,
  });

  @override
  State<CategoryItemPage> createState() => _CategoryItemPageState();
}

class _CategoryItemPageState extends State<CategoryItemPage> {
  final productController = Get.put(ProductController());

  @override
  void initState() {
    super.initState();
    productController.fetchProductsByCategory(widget.categoryId);
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
        centerTitle: true,
        title: Text(
          '${widget.categoryName}',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => FilterPage()),
              );
            },
            icon: Icon(Icons.sort),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Obx(
          () => productController.productByCategories.isEmpty
              ? Center(
                  child: Text(
                    'Product is empty.',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                )
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: .8,
                  ),
                  itemCount: productController.productByCategories.length,
                  itemBuilder: (context, index) {
                    var item = productController.productByCategories[index];
                    return CardItemWidget(item: item);
                  },
                ),
        ),
      ),
    );
  }
}
