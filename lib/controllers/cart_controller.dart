import 'package:get/get.dart';
import 'package:grocery_app/models/cart.model.dart';
import 'package:grocery_app/models/grocery.model.dart';
import 'package:grocery_app/services/apis/cart_api.dart';
import 'package:http/http.dart';

class CartController extends GetxController {
  final _cartApi = CartApi();
  late var cart = Cart.empty().obs;
  final items = <Items>[].obs;

  @override
  void onInit() {
    super.onInit();
    getCart();
  }

  // create cart
  Future<void> createCart(String productId) async {
    await _cartApi.createCart(productId);
    await getCart();
  }

  Future<void> getCart() async {
    final data = await _cartApi.fetchCart();
    cart = data.obs;
    items.assignAll(cart.value.items ?? []);
  }

  // update item qty
  Future<void> updateItemQuantity({
    required String productId,
    required int quantity,
  }) async {
    int index =
        cart.value.items?.indexWhere((item) => item.product!.id == productId)
            as int;
    if (index != -1) {
      var currentQty = cart.value.items![index].quantity ?? 0;
      var newQty = currentQty + quantity;
      if (newQty < 1) return;
      // update locally
      cart.value.items![index].quantity = newQty;
      // refresh ui
      cart.refresh();
      // update server
      await _cartApi.updateItemQuantity(productId: productId, quantity: newQty);
    }
  }

  // remove item from cart
  Future<void> removeCartItem({required String productId}) async {
    int? index = cart.value.items?.indexWhere(
      (element) => element.product!.id == productId,
    );
    if (index != -1) {
      cart.value.items?.removeAt(index!);
    }
    cart.refresh();
    await _cartApi.removeCartItem(productId: productId);
  }
}
