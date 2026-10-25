import 'package:souqna_anaqa/repositories/cart/cart_result.dart';

abstract interface class CartRepository {
  Future<CartResult> fetch();

  Future<CartResult> add({
    required int productId,
    required int quantity,
    Map<String, String>? options,
  });

  Future<CartResult> updateQuantity(int itemId, int quantity);

  Future<CartResult> remove(int itemId);

  Future<CartResult> applyCoupon(String code);

  Future<CartResult> removeCoupon();
}
