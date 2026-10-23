import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:souqna_anaqa/utils/responsive.dart';

import 'package:souqna_anaqa/getx_controller/app_getx_controller.dart';
import 'package:souqna_anaqa/getx_controller/cart_getx_controller.dart';
import 'package:souqna_anaqa/getx_controller/order_getx_controller.dart';
import 'package:souqna_anaqa/getx_controller/user_profile_getx_controller.dart';
import 'package:souqna_anaqa/models/cart.dart';
import 'package:souqna_anaqa/screen/setting/checkout_confirm_button.dart';
import 'package:souqna_anaqa/screen/setting/checkout_form_fields.dart';
import 'package:souqna_anaqa/screen/setting/checkout_order_summary.dart';
import 'package:souqna_anaqa/screen/setting/order_success_screen.dart';
import 'package:souqna_anaqa/utils/app_strings.dart';
import 'package:souqna_anaqa/widget/glass_app_bar.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<PaymentScreen> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController(
    text: Get.find<UserProfileGetxController>().userProfile.value?.name,
  );
  final _phone = TextEditingController(
    text: Get.find<UserProfileGetxController>().userProfile.value?.phone,
  );
  final _address = TextEditingController();
  final _notes = TextEditingController();
  String _payment = 'cash';

  @override
  void dispose() {
    for (final controller in [_name, _phone, _address, _notes]) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_form.currentState!.validate()) return;
    final orderController = Get.find<OrderGetxController>();
    final order = await orderController.checkout(
      name: _name.text,
      phone: _phone.text,
      address: _address.text,
      notes: _notes.text,
      payment: _payment,
    );
    if (!mounted) return;
    if (order != null) {
      Get.off(
        () => OrderSuccessScreen(order: order),
        transition: Transition.zoom,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Get.find<CartGetxController>();
    final summary = CartSummary(
      items: cart.items.toList(),
      itemsCount: cart.itemsCount.value,
      subtotal: cart.subtotal.value,
      discount: cart.discount.value,
      deliveryFee: cart.deliveryFee.value,
      total: cart.total.value,
      couponCode: cart.couponCode.value,
      couponError: cart.couponError.value,
      minOrder: cart.minOrder.value,
      meetsMinOrder: cart.meetsMinOrder.value,
    );
    final storeAddress = Get.find<AppGetxController>().store.value?.address;

    return Scaffold(
      appBar: const GlassAppBar(title: Text(AppStrings.checkout)),
      body: Form(
        key: _form,
        child: ListView(
          padding: centeredPadding(
            MediaQuery.sizeOf(context).width,
            maxWidth: Responsive.readingMaxWidth,
            top: 8,
            bottom: 140 + MediaQuery.paddingOf(context).bottom,
          ),
          children: [
            CheckoutFormFields(
              name: _name,
              phone: _phone,
              address: _address,
              notes: _notes,
              payment: _payment,
              onPaymentChanged: (payment) => setState(() => _payment = payment),
            ),
            CheckoutOrderSummary(summary: summary, storeAddress: storeAddress),
          ],
        ),
      ),
      bottomSheet: CheckoutConfirmButton(
        total: summary.total,
        onPressed: _submit,
      ),
    );
  }
}
