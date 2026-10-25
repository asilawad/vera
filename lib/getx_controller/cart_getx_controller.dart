import 'package:get/get.dart';
import 'package:souqna_anaqa/getx_controller/cart_controller_state.dart';
import 'package:souqna_anaqa/models/cart.dart';
import 'package:souqna_anaqa/preferences/user_getstorage.dart';
import 'package:souqna_anaqa/repositories/cart/api_cart_repository.dart';
import 'package:souqna_anaqa/repositories/cart/cart_repository.dart';
import 'package:souqna_anaqa/repositories/cart/cart_result.dart';
import 'package:souqna_anaqa/utils/app_strings.dart';
import 'package:souqna_anaqa/utils/helpers.dart';

part 'cart_getx_controller_actions.dart';

class CartGetxController extends GetxController {
  CartGetxController({
    CartRepository? repository,
    void Function({required String message, bool error})? notify,
  }) : _repository = repository ?? ApiCartRepository(),
       _notify = notify ?? Helpers.showSnackBar;

  final CartRepository _repository;
  final void Function({required String message, bool error}) _notify;
  final _state = CartControllerState();
  final isLoading = false.obs;
  final isSubmitting = false.obs;
  final busyItemId = RxnInt();
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    fetchCart();
    super.onInit();
  }

  Future<void> fetchCart() async {
    if (UserGetStorage().getToken().isEmpty) return;
    isLoading.value = true;
    _refreshDisplayState();
    errorMessage.value = '';
    try {
      switch (await _repository.fetch()) {
        case CartSuccess(:final summary):
          _apply(summary);
        case CartFailure(:final message):
          errorMessage.value = message;
      }
    } finally {
      isLoading.value = false;
      _refreshDisplayState();
    }
  }

  Future<bool> addToCart({
    required int productId,
    int quantity = 1,
    Map<String, String>? options,
  }) async {
    isSubmitting.value = true;
    try {
      return _handle(
        await _repository.add(
          productId: productId,
          quantity: quantity,
          options: options,
        ),
        successMessage: AppStrings.cartAddSucceeded,
      );
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> updateQuantity(CartItem item, int quantity) async {
    if (quantity < 1) return removeItem(item);
    busyItemId.value = item.id;
    try {
      _handle(await _repository.updateQuantity(item.id, quantity));
    } finally {
      busyItemId.value = null;
    }
  }

  Future<void> removeItem(CartItem item) async {
    busyItemId.value = item.id;
    try {
      if (!_handle(await _repository.remove(item.id))) fetchCart();
    } finally {
      busyItemId.value = null;
    }
  }

  Future<bool> applyCoupon(String code) async {
    if (code.trim().isEmpty) return false;
    isSubmitting.value = true;
    try {
      return _handle(
        await _repository.applyCoupon(code.trim()),
        successMessage: AppStrings.cartCouponApplied,
      );
    } finally {
      isSubmitting.value = false;
    }
  }
}
