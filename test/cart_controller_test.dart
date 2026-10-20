import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';
import 'package:souqna_anaqa/getx_controller/cart_getx_controller.dart';
import 'package:souqna_anaqa/models/cart.dart';
import 'package:souqna_anaqa/repositories/cart/cart_repository.dart';
import 'package:souqna_anaqa/repositories/cart/cart_result.dart';

class FakeCartRepository implements CartRepository {
  Future<CartResult>? pendingFetch;
  Future<CartResult>? pendingAdd;
  Future<CartResult>? pendingUpdate;

  @override
  Future<CartResult> fetch() =>
      pendingFetch ?? Future.value(CartSuccess(CartSummary(), null));

  @override
  Future<CartResult> add({
    required int productId,
    required int quantity,
    Map<String, String>? options,
  }) => pendingAdd ?? Future.value(CartSuccess(CartSummary(), null));

  @override
  Future<CartResult> updateQuantity(int itemId, int quantity) =>
      pendingUpdate ?? Future.value(CartSuccess(CartSummary(), null));

  @override
  Future<CartResult> remove(int itemId) =>
      Future.value(CartSuccess(CartSummary(), null));

  @override
  Future<CartResult> applyCoupon(String code) =>
      Future.value(CartSuccess(CartSummary(), null));

  @override
  Future<CartResult> removeCoupon() =>
      Future.value(CartSuccess(CartSummary(), null));
}

void main() {
  setUpAll(() async => GetStorage.init());
  setUp(() async => GetStorage().write('token', 'test-token'));

  test('tracks request flags and applies count and item state', () async {
    final repository = FakeCartRepository();
    final fetch = Completer<CartResult>();
    repository.pendingFetch = fetch.future;
    final controller = CartGetxController(repository: repository);

    final fetchTask = controller.fetchCart();
    expect(controller.isLoading.value, isTrue);
    fetch.complete(CartSuccess(CartSummary(), null));
    await fetchTask;
    expect(controller.isLoading.value, isFalse);

    final item = CartItem(id: 8, productId: 3, quantity: 1);
    final add = Completer<CartResult>();
    repository.pendingAdd = add.future;
    final addTask = controller.addToCart(productId: 3);
    expect(controller.isSubmitting.value, isTrue);
    add.complete(
      CartSuccess(CartSummary(items: [item], itemsCount: 1, total: 10), null),
    );
    expect(await addTask, isTrue);
    expect(controller.isSubmitting.value, isFalse);
    expect(controller.itemsCount.value, 1);
    expect(controller.items.single.id, 8);
    expect(controller.total.value, 10);

    final update = Completer<CartResult>();
    repository.pendingUpdate = update.future;
    final updateTask = controller.updateQuantity(item, 2);
    expect(controller.busyItemId.value, 8);
    update.complete(CartSuccess(CartSummary(items: [item]), null));
    await updateTask;
    expect(controller.busyItemId.value, isNull);
  });

  test('reports repository failures through notify', () async {
    final notifications = <({String message, bool error})>[];
    final repository = FakeCartRepository()
      ..pendingAdd = Future.value(const CartFailure('coupon rejected'));
    final controller = CartGetxController(
      repository: repository,
      notify: ({required message, error = false}) {
        notifications.add((message: message, error: error));
      },
    );

    expect(await controller.addToCart(productId: 5), isFalse);
    expect(notifications, [(message: 'coupon rejected', error: true)]);
    expect(controller.isSubmitting.value, isFalse);
  });
}
