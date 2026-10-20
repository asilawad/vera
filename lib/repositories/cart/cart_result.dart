import 'package:souqna_anaqa/models/cart.dart';

sealed class CartResult {
  const CartResult();
}

final class CartSuccess extends CartResult {
  const CartSuccess(this.summary, this.message);

  final CartSummary summary;
  final String? message;
}

final class CartFailure extends CartResult {
  const CartFailure(this.message);

  final String message;
}
