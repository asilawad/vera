part of 'cart_getx_controller.dart';

extension CartGetxControllerState on CartGetxController {
  Rx<CartSummary> get summary => _state.summary;
  RxInt get itemsCount => _state.itemsCount;
  RxList<CartItem> get items => _state.items;
  RxDouble get total => _state.total;
  RxDouble get subtotal => _state.subtotal;
  RxDouble get discount => _state.discount;
  RxDouble get deliveryFee => _state.deliveryFee;
  RxnString get couponCode => _state.couponCode;
  RxnString get couponError => _state.couponError;
  RxDouble get minOrder => _state.minOrder;
  RxBool get meetsMinOrder => _state.meetsMinOrder;
  RxBool get isEmpty => _state.isEmpty;
  Rx<CartDisplayState> get displayState => _state.displayState;
  int get count => itemsCount.value;
}

extension CartGetxControllerHelpers on CartGetxController {
  Future<void> removeCoupon() async {
    _handle(await _repository.removeCoupon());
  }

  void reset() => _apply(CartSummary());

  bool _handle(CartResult result, {String? successMessage}) {
    switch (result) {
      case CartSuccess(:final summary, :final message):
        _apply(summary);
        if (successMessage != null) {
          _notify(message: message ?? successMessage);
        }
        return true;
      case CartFailure(:final message):
        _notify(message: message, error: true);
        return false;
    }
  }

  void _apply(CartSummary value) {
    _state.apply(value);
    _refreshDisplayState();
  }

  void _refreshDisplayState() {
    _state.displayState.value = isLoading.value && isEmpty.value
        ? CartDisplayState.loading
        : isEmpty.value
        ? CartDisplayState.empty
        : CartDisplayState.content;
  }
}
