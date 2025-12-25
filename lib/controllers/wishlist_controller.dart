import 'package:get/get.dart';
import 'package:grocery_app/models/wishlist.model.dart';
import 'package:grocery_app/services/apis/wishlist_api.dart';

class WishlistController extends GetxController {
  final _wishlistApi = WishlistApi();
  var wishlist = Wishlist.empty().obs;

  @override
  void onInit() {
    super.onInit();
    fetchWishlist();
  }

  // create wishlist
  Future<void> createWishlist({required String productId}) async {
    await _wishlistApi.createWishlist(productId: productId);
    fetchWishlist();
  }

  // fetch wishlist
  Future<void> fetchWishlist() async {
    final data = await _wishlistApi.fetchWishlist();
    wishlist.value = data;
  }

  // remove a product from wishlist
  Future<void> removeProductFromWishlist({required String productId}) async {
    await _wishlistApi.isRemoveProductFromWishlist(productId: productId);
    // like update state
    fetchWishlist();
  }

  // product is in wishlist
  bool isInWishlist(String productId) {
    return wishlist.value.items!.any((item) => item.product!.id == productId);
  }

  Future<void> toggleWishlist({required String productId}) async {
    if (isInWishlist(productId)) {
      await removeProductFromWishlist(productId: productId);
    } else {
      await createWishlist(productId: productId);
    }
    fetchWishlist(); // refresh UI state
  }
}
