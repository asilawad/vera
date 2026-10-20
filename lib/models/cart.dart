import 'package:souqna_anaqa/utils/helpers.dart';

class CartResponse {
  bool? success;
  String? message;
  CartSummary? data;

  CartResponse({this.success, this.message, this.data});

  CartResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? CartSummary.fromJson(json['data']) : null;
  }
}

class CartItem {
  int id = 0;
  int productId = 0;
  String name = '';
  String? image;
  double unitPrice = 0;
  double originalPrice = 0;
  int quantity = 1;
  Map<String, String> options = {};
  double lineTotal = 0;
  int stock = 0;
  bool isAvailable = true;

  CartItem({
    this.id = 0,
    this.productId = 0,
    this.name = '',
    this.image,
    this.unitPrice = 0,
    this.originalPrice = 0,
    this.quantity = 1,
    this.options = const {},
    this.lineTotal = 0,
    this.stock = 0,
    this.isAvailable = true,
  });

  CartItem.fromJson(Map<String, dynamic> json) {
    id = intFromJson(json['id']);
    productId = intFromJson(json['product_id']);
    name = json['name']?.toString() ?? '';
    image = json['image']?.toString();
    unitPrice = numFromJson(json['unit_price']);
    originalPrice = numFromJson(json['original_price'], unitPrice);
    quantity = intFromJson(json['quantity'], 1);
    if (json['options'] is Map) {
      options = <String, String>{};
      json['options'].forEach((k, v) {
        options[k.toString()] = v.toString();
      });
    }
    lineTotal = numFromJson(json['line_total'], unitPrice * quantity);
    stock = intFromJson(json['stock']);
    isAvailable = boolFromJson(json['is_available'], true);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['name'] = name;
    data['image'] = image;
    data['unit_price'] = unitPrice;
    data['original_price'] = originalPrice;
    data['quantity'] = quantity;
    data['options'] = options;
    data['line_total'] = lineTotal;
    data['stock'] = stock;
    data['is_available'] = isAvailable;
    return data;
  }
}

/// الملخص الكامل الذي يعيده الخادم مع كل عملية على السلة.
class CartSummary {
  List<CartItem> items = [];
  int itemsCount = 0;
  double subtotal = 0;
  double discount = 0;
  double deliveryFee = 0;
  double total = 0;
  String? couponCode;
  String? couponError;
  double minOrder = 0;
  bool meetsMinOrder = true;

  CartSummary({
    this.items = const [],
    this.itemsCount = 0,
    this.subtotal = 0,
    this.discount = 0,
    this.deliveryFee = 0,
    this.total = 0,
    this.couponCode,
    this.couponError,
    this.minOrder = 0,
    this.meetsMinOrder = true,
  });

  bool get isEmpty => items.isEmpty;

  CartSummary.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null && json['items'] is List) {
      items = <CartItem>[];
      for (final item in json['items']) {
        if (item is Map) {
          items.add(CartItem.fromJson(Map<String, dynamic>.from(item)));
        }
      }
    }
    itemsCount = intFromJson(json['items_count']);
    subtotal = numFromJson(json['subtotal']);
    discount = numFromJson(json['discount']);
    deliveryFee = numFromJson(json['delivery_fee']);
    total = numFromJson(json['total'], subtotal - discount + deliveryFee);
    couponCode = json['coupon_code']?.toString();
    couponError = json['coupon_error']?.toString();
    minOrder = numFromJson(json['min_order']);
    meetsMinOrder = boolFromJson(json['meets_min_order'], true);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['items'] = items.map((v) => v.toJson()).toList();
    data['items_count'] = itemsCount;
    data['subtotal'] = subtotal;
    data['discount'] = discount;
    data['delivery_fee'] = deliveryFee;
    data['total'] = total;
    data['coupon_code'] = couponCode;
    data['coupon_error'] = couponError;
    data['min_order'] = minOrder;
    data['meets_min_order'] = meetsMinOrder;
    return data;
  }
}
