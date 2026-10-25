import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:souqna_anaqa/api/api_settings.dart';
import 'package:souqna_anaqa/repositories/cart/api_cart_repository.dart';
import 'package:souqna_anaqa/repositories/cart/cart_result.dart';
import 'package:souqna_anaqa/utils/app_strings.dart';

Map<String, dynamic> cartFixture() =>
    jsonDecode(File('test/fixtures/cart.json').readAsStringSync())
        as Map<String, dynamic>;

http.Response jsonResponse(Object body, {int statusCode = 200}) =>
    http.Response(
      jsonEncode(body),
      statusCode,
      headers: {'content-type': 'application/json; charset=utf-8'},
    );

void main() {
  test('fetch parses the cart fixture and sends auth headers', () async {
    final client = MockClient((request) async {
      expect(request.method, 'GET');
      expect(request.url.toString(), ApiSettings.cart);
      expect(request.headers['Accept'], 'application/json');
      expect(request.headers['Accept-Language'], 'ar');
      expect(request.headers['Authorization'], 'Bearer test-token');
      return jsonResponse(cartFixture());
    });
    final repository = ApiCartRepository(
      client: client,
      tokenProvider: () => 'test-token',
    );

    final result = await repository.fetch();

    expect(result, isA<CartSuccess>());
    expect((result as CartSuccess).summary.isEmpty, isTrue);
  });

  test('maps API failure messages and add request bodies', () async {
    final client = MockClient((request) async {
      expect(request.method, 'POST');
      expect(request.headers['Content-Type'], 'application/json');
      expect(jsonDecode(request.body), {
        'product_id': 42,
        'quantity': 2,
        'options': {'size': 'M'},
      });
      return jsonResponse({
        'success': false,
        'message': AppStrings.cartFetchFailed,
      }, statusCode: 422);
    });
    final repository = ApiCartRepository(
      client: client,
      tokenProvider: () => 'test-token',
    );

    final result = await repository.add(
      productId: 42,
      quantity: 2,
      options: {'size': 'M'},
    );

    expect(result, isA<CartFailure>());
    expect((result as CartFailure).message, AppStrings.cartFetchFailed);
  });

  test('maps connection errors to the shared fallback', () async {
    final client = MockClient(
      (_) async => throw const SocketException('offline'),
    );
    final repository = ApiCartRepository(client: client);

    final result = await repository.fetch();

    expect(result, isA<CartFailure>());
    expect((result as CartFailure).message, AppStrings.cartConnectionError);
  });

  test('maps request timeout to the shared fallback', () async {
    final client = MockClient((_) => Completer<http.Response>().future);
    final repository = ApiCartRepository(client: client);

    final result = await repository.fetch().timeout(
      ApiSettings.timeout + const Duration(seconds: 1),
    );

    expect(result, isA<CartFailure>());
    expect((result as CartFailure).message, AppStrings.cartConnectionError);
  });
}
