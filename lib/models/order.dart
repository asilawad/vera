import 'package:souqna_anaqa/utils/helpers.dart';

class OrdersResponse {
  bool? success;
  String? message;
  List<Order>? data;

  OrdersResponse({this.success, this.message, this.data});

  OrdersResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Order>[];
      json['data'].forEach((v) {
        data!.add(Order.fromJson(v));
      });
    }
  }
}

class OrderResponse {
  bool? success;
  String? message;
  Order? data;

  OrderResponse({this.success, this.message, this.data});

  OrderResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Order.fromJson(json['data']) : null;
  }
}

class TimelineStep {
  String status = '';
  String label = '';
  bool done = false;
  String? at;
  String? note;

  TimelineStep({
    this.status = '',
    this.label = '',
    this.done = false,
    this.at,
    this.note,
  });

  TimelineStep.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? '';
    label = json['label'] ?? '';
    done = json['done'] ?? false;
    at = json['at'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['label'] = label;
    data['done'] = done;
    data['at'] = at;
    data['note'] = note;
    return data;
  }
}

class OrderLine {
  int? productId;
  String name = '';
  String? image;
  double price = 0;
  int quantity = 0;
  double total = 0;
  Map<String, String> options = {};

  OrderLine({
    this.productId,
    this.name = '',
    this.image,
    this.price = 0,
    this.quantity = 0,
    this.total = 0,
    this.options = const {},
  });

  OrderLine.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    name = json['name'] ?? '';
    image = json['image'];
    price = (json['price'] as num? ?? 0).toDouble();
    quantity = json['quantity'] ?? 0;
    total = (json['total'] as num? ?? 0).toDouble();
    if (json['options'] is Map) {
      options = <String, String>{};
      json['options'].forEach((k, v) {
        options[k] = v.toString();
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['name'] = name;
    data['image'] = image;
    data['price'] = price;
    data['quantity'] = quantity;
    data['total'] = total;
    data['options'] = options;
    return data;
  }
}

class Order {
  int id = 0;
  String number = '';
  String status = '';
  String statusLabel = '';
  double subtotal = 0;
  double discount = 0;
  double deliveryFee = 0;
  double total = 0;
  String? couponCode;
  String paymentLabel = '';
  String customerName = '';
  String phone = '';
  String address = '';
  String? notes;
  bool canCancel = false;
  int itemsCount = 0;
  List<OrderLine> items = [];
  List<TimelineStep> timeline = [];
  String createdAt = '';

  Order({
    this.id = 0,
    this.number = '',
    this.status = '',
    this.statusLabel = '',
    this.subtotal = 0,
    this.discount = 0,
    this.deliveryFee = 0,
    this.total = 0,
    this.couponCode,
    this.paymentLabel = '',
    this.customerName = '',
    this.phone = '',
    this.address = '',
    this.notes,
    this.canCancel = false,
    this.itemsCount = 0,
    this.items = const [],
    this.timeline = const [],
    this.createdAt = '',
  });

  Order.fromJson(Map<String, dynamic> json) {
    id = intFromJson(json['id']);
    number = json['number']?.toString() ?? '';
    status = json['status']?.toString() ?? '';
    statusLabel = json['status_label']?.toString() ?? '';
    subtotal = numFromJson(json['subtotal']);
    discount = numFromJson(json['discount']);
    deliveryFee = numFromJson(json['delivery_fee']);
    total = numFromJson(json['total'], subtotal - discount + deliveryFee);
    couponCode = json['coupon_code']?.toString();
    paymentLabel = json['payment_method_label']?.toString() ?? '';
    customerName = json['customer_name']?.toString() ?? '';
    phone = json['phone']?.toString() ?? '';
    address = json['address']?.toString() ?? '';
    notes = json['notes']?.toString();
    canCancel = boolFromJson(json['can_cancel']);
    itemsCount = intFromJson(json['items_count']);
    if (json['items'] != null && json['items'] is List) {
      items = <OrderLine>[];
      for (final item in json['items']) {
        if (item is Map) {
          items.add(OrderLine.fromJson(Map<String, dynamic>.from(item)));
        }
      }
    }
    if (json['timeline'] != null && json['timeline'] is List) {
      timeline = <TimelineStep>[];
      for (final step in json['timeline']) {
        if (step is Map) {
          timeline.add(TimelineStep.fromJson(Map<String, dynamic>.from(step)));
        }
      }
    }
    createdAt = json['created_at']?.toString() ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['number'] = number;
    data['status'] = status;
    data['status_label'] = statusLabel;
    data['subtotal'] = subtotal;
    data['discount'] = discount;
    data['delivery_fee'] = deliveryFee;
    data['total'] = total;
    data['coupon_code'] = couponCode;
    data['payment_method_label'] = paymentLabel;
    data['customer_name'] = customerName;
    data['phone'] = phone;
    data['address'] = address;
    data['notes'] = notes;
    data['can_cancel'] = canCancel;
    data['items_count'] = itemsCount;
    data['items'] = items.map((v) => v.toJson()).toList();
    data['timeline'] = timeline.map((v) => v.toJson()).toList();
    data['created_at'] = createdAt;
    return data;
  }
}
