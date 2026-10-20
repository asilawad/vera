import 'package:get/get.dart';
import 'package:souqna_anaqa/models/cart.dart';

enum CartDisplayState { loading, empty, content }

class CartControllerState {
  final summary = CartSummary().obs;
  final itemsCount = 0.obs;
  final items = <CartItem>[].obs;
  final total = 0.0.obs;
  final subtotal = 0.0.obs;
  final discount = 0.0.obs;
  final deliveryFee = 0.0.obs;
  final couponCode = RxnString();
  final couponError = RxnString();
  final minOrder = 0.0.obs;
  final meetsMinOrder = true.obs;
  final isEmpty = true.obs;
  final displayState = CartDisplayState.empty.obs;

  void apply(CartSummary value) {
    summary.value = value;
    itemsCount.value = value.itemsCount;
    items.assignAll(value.items);
    total.value = value.total;
    subtotal.value = value.subtotal;
    discount.value = value.discount;
    deliveryFee.value = value.deliveryFee;
    couponCode.value = value.couponCode;
    couponError.value = value.couponError;
    minOrder.value = value.minOrder;
    meetsMinOrder.value = value.meetsMinOrder;
    isEmpty.value = value.isEmpty;
  }
}
