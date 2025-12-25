import 'package:get/get.dart';
import 'package:grocery_app/services/apis/category_api.dart';

import '../models/category.model.dart';

class CategoryController extends GetxController {
  // get categories
  final categoryApi = CategoryApi();
  var categoryList = <Category>[].obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    getCategory();
  }

  Future<List<Category>> getCategory() async {
    isLoading(true);
    final data = await categoryApi.fetchCategories();
    categoryList.addAll(data);
    isLoading(false);
    return data;
  }
}
