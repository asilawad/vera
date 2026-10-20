import 'package:flutter/material.dart';

import 'package:souqna_anaqa/utils/helpers.dart';

class StoreInfoResponse {
  bool? success;
  String? message;
  StoreInfo? data;

  StoreInfoResponse({this.success, this.message, this.data});

  StoreInfoResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? StoreInfo.fromJson(json['data']) : null;
  }
}

class StoreInfo {
  int id = 0;
  String name = '';
  String slug = '';
  String? tagline;
  String? description;
  String? logo;
  String? cover;
  Color primaryColor = const Color(0xFFF59E0B);
  String? phone;
  String? whatsapp;
  String? address;
  double deliveryFee = 0;
  double minOrder = 0;
  String currencySymbol = '₪';

  StoreInfo({
    this.id = 0,
    this.name = '',
    this.slug = '',
    this.tagline,
    this.description,
    this.logo,
    this.cover,
    this.primaryColor = const Color(0xFFF59E0B),
    this.phone,
    this.whatsapp,
    this.address,
    this.deliveryFee = 0,
    this.minOrder = 0,
    this.currencySymbol = '₪',
  });

  StoreInfo.fromJson(Map<String, dynamic> json) {
    id = intFromJson(json['id']);
    name = json['name']?.toString() ?? '';
    slug = json['slug']?.toString() ?? '';
    tagline = json['tagline']?.toString();
    description = json['description']?.toString();
    logo = json['logo']?.toString();
    cover = json['cover']?.toString();
    if (json['theme'] != null && json['theme'] is Map) {
      primaryColor = Fmt.hex(json['theme']['primary_color']?.toString());
    }
    if (json['contact'] != null && json['contact'] is Map) {
      phone = json['contact']['phone']?.toString();
      whatsapp = json['contact']['whatsapp']?.toString();
      address = json['contact']['address']?.toString();
    }
    if (json['delivery'] != null && json['delivery'] is Map) {
      deliveryFee = numFromJson(json['delivery']['fee']);
      minOrder = numFromJson(json['delivery']['min_order']);
    }
    currencySymbol = json['currency_symbol']?.toString() ?? '₪';
  }
}
