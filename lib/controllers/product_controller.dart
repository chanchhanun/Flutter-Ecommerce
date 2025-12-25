import 'package:get/get.dart';
import 'package:grocery_app/constants/app_const.dart';
import 'package:grocery_app/models/product.model.dart';
import 'package:grocery_app/services/apis/product_api.dart';
import 'dart:developer' as dev;

class ProductController extends GetxController {
  final productApi = ProductApi();
  final productList = <Product>[].obs;
  final isLoading = false.obs;
  var filterProducts = <Product>[].obs;
  var quantity = 1.obs;
  final productByCategories = <Product>[].obs;
  var productExclusive = <Product>[].obs;
  // haven't done yet
  var productBestSelling = <Product>[].obs;
  var productNewest = <Product>[].obs;
  var singleProduct = Product().obs;
  var isLoadingSingleProduct = false.obs;

  @override
  void onInit() {
    super.onInit();
    getProduct().then((value) => filterProducts.assignAll(productList));
    fetchProductExclusive();
    fetchProductBestSelling().then((value) => productNewest.assignAll(value));
    fetchProductNewest();
  }

  Future<void> getProduct() async {
    isLoading(true);
    final products = await productApi.fetchProduct();
    productList.assignAll(products);
    isLoading(false);
  }

  // get product by category
  Future<void> fetchProductsByCategory(String categoryId) async {
    try {
      isLoading.value = true;
      final products = await productApi.fetchProductByCategoryId(categoryId);
      print('data : $products');
      productByCategories.clear();
      productByCategories.value = products; // RxList updates automatically
    } finally {
      isLoading.value = false;
    }
  }

  void onSearh(String query) {
    if (query.isEmpty) {
      // show all product
      filterProducts.assignAll(productList);
    } else {
      final result = productList
          .where(
            (item) => item.name!.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
      filterProducts.assignAll(result);
    }
  }

  // fetch product exclusive
  Future<List<Product>> fetchProductExclusive() async {
    final products = await productApi.fetchProductExclusive();
    productExclusive.assignAll(products);
    return products;
  }

  // best selling
  Future<List<Product>> fetchProductBestSelling() async {
    final products = await productApi.fetchProductBestSelling();
    productBestSelling.assignAll(products);
    return products;
  }

  // replace it by discount
  Future<List<Product>> fetchProductNewest() async {
    final products = await productApi.fetchProductNewest();
    productNewest.assignAll(products);
    return products;
  }

  // fetch single product
  Future<void> fetchSingleProduct({required String productId}) async {
    isLoadingSingleProduct(true);
    final data = await productApi.fetchSingleProduct(productId: productId);
    singleProduct.value = data;
    isLoadingSingleProduct(false);
  }

  // serach product
  Future<void> searchSuggestion({required String productName}) async {
    await productApi.searchSuggestion(productName: productName);
  }
}
