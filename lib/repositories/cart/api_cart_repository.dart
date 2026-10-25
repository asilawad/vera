import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:souqna_anaqa/api/api_settings.dart';
import 'package:souqna_anaqa/models/cart.dart';
import 'package:souqna_anaqa/preferences/user_getstorage.dart';
import 'package:souqna_anaqa/repositories/cart/cart_repository.dart';
import 'package:souqna_anaqa/repositories/cart/cart_result.dart';
import 'package:souqna_anaqa/utils/app_strings.dart';

class ApiCartRepository implements CartRepository {
  ApiCartRepository({http.Client? client, String Function()? tokenProvider})
    : _client = client ?? http.Client(),
      _tokenProvider = tokenProvider ?? (() => UserGetStorage().getToken());

  final http.Client _client;
  final String Function() _tokenProvider;

  @override
  Future<CartResult> fetch() => _send(
    'GET',
    Uri.parse(ApiSettings.cart),
    successStatusCodes: const {200},
    fallbackMessage: AppStrings.cartFetchFailed,
  );

  @override
  Future<CartResult> add({
    required int productId,
    required int quantity,
    Map<String, String>? options,
  }) => _send(
    'POST',
    Uri.parse(ApiSettings.cartItems),
    body: {
      'product_id': productId,
      'quantity': quantity,
      if (options != null && options.isNotEmpty) 'options': options,
    },
    successStatusCodes: const {200, 201},
    fallbackMessage: AppStrings.cartAddFailed,
  );

  @override
  Future<CartResult> updateQuantity(int itemId, int quantity) => _send(
    'PATCH',
    Uri.parse('${ApiSettings.cartItems}/$itemId'),
    body: {'quantity': quantity},
    successStatusCodes: const {200},
    fallbackMessage: AppStrings.cartQuantityUpdateFailed,
  );

  @override
  Future<CartResult> remove(int itemId) => _send(
    'DELETE',
    Uri.parse('${ApiSettings.cartItems}/$itemId'),
    successStatusCodes: const {200},
    fallbackMessage: AppStrings.cartItemRemoveFailed,
  );

  @override
  Future<CartResult> applyCoupon(String code) => _send(
    'POST',
    Uri.parse(ApiSettings.cartCoupon),
    body: {'code': code},
    successStatusCodes: const {200},
    fallbackMessage: AppStrings.cartCouponInvalid,
  );

  @override
  Future<CartResult> removeCoupon() => _send(
    'DELETE',
    Uri.parse(ApiSettings.cartCoupon),
    successStatusCodes: const {200},
    fallbackMessage: AppStrings.cartCouponRemoveFailed,
  );

  Future<CartResult> _send(
    String method,
    Uri url, {
    Object? body,
    required Set<int> successStatusCodes,
    required String fallbackMessage,
  }) async {
    try {
      final request = http.Request(method, url)
        ..headers.addAll({
          'Accept': 'application/json',
          'Accept-Language': 'ar',
          'Authorization': 'Bearer ${_tokenProvider()}',
          if (body != null) 'Content-Type': 'application/json',
        });
      if (body != null) request.body = jsonEncode(body);

      final response = await Future<http.Response>(() async {
        final streamed = await _client.send(request);
        return http.Response.fromStream(streamed);
      }).timeout(ApiSettings.timeout);
      final decoded = jsonDecode(utf8.decode(response.bodyBytes));
      if (decoded is! Map<String, dynamic>) {
        return CartFailure(fallbackMessage);
      }
      final message = decoded['message']?.toString();

      if (successStatusCodes.contains(response.statusCode) &&
          decoded['success'] == true) {
        return CartSuccess(
          CartResponse.fromJson(decoded).data ?? CartSummary(),
          message,
        );
      }
      return CartFailure(message ?? fallbackMessage);
    } catch (_) {
      return const CartFailure(AppStrings.cartConnectionError);
    }
  }
}
