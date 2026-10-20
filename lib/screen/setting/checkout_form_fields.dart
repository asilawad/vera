import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:souqna_anaqa/utils/app_colors.dart';
import 'package:souqna_anaqa/utils/app_strings.dart';

class CheckoutFormFields extends StatelessWidget {
  const CheckoutFormFields({
    super.key,
    required this.name,
    required this.phone,
    required this.address,
    required this.notes,
    required this.payment,
    required this.onPaymentChanged,
  });

  final TextEditingController name;
  final TextEditingController phone;
  final TextEditingController address;
  final TextEditingController notes;
  final String payment;
  final ValueChanged<String> onPaymentChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CheckoutStepTitle(number: 1, title: AppStrings.shippingDetails),
        TextFormField(
          controller: name,
          decoration: const InputDecoration(
            labelText: AppStrings.recipientName,
            prefixIcon: Icon(Icons.person_outline_rounded),
          ),
          validator: (value) => (value ?? '').trim().length < 2
              ? AppStrings.recipientNameInvalid
              : null,
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: phone,
          keyboardType: TextInputType.phone,
          textDirection: TextDirection.ltr,
          decoration: const InputDecoration(
            labelText: AppStrings.phoneNumber,
            prefixIcon: Icon(Icons.phone_outlined),
          ),
          validator: (value) =>
              (value ?? '').trim().length < 7 ? AppStrings.phoneInvalid : null,
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: address,
          maxLines: 2,
          decoration: const InputDecoration(
            labelText: AppStrings.detailedAddress,
            hintText: AppStrings.addressHint,
            prefixIcon: Icon(Icons.location_on_outlined),
          ),
          validator: (value) => (value ?? '').trim().length < 5
              ? AppStrings.addressInvalid
              : null,
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: notes,
          decoration: const InputDecoration(
            labelText: AppStrings.deliveryNotes,
            prefixIcon: Icon(Icons.sticky_note_2_outlined),
          ),
        ),
        const CheckoutStepTitle(number: 2, title: AppStrings.paymentMethod),
        _PaymentOption(
          value: 'cash',
          group: payment,
          icon: Icons.payments_outlined,
          title: AppStrings.cashOnDelivery,
          subtitle: AppStrings.cashAgent,
          onChanged: onPaymentChanged,
        ),
        const SizedBox(height: 10),
        _PaymentOption(
          value: 'card_demo',
          group: payment,
          icon: Icons.credit_card_rounded,
          title: AppStrings.demoCard,
          subtitle: AppStrings.demoPayment,
          onChanged: onPaymentChanged,
        ),
      ],
    );
  }
}

class CheckoutStepTitle extends StatelessWidget {
  const CheckoutStepTitle({
    super.key,
    required this.number,
    required this.title,
  });

  final int number;
  final String title;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Padding(
      padding: const EdgeInsets.only(top: 22, bottom: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 13,
            backgroundColor: primary,
            child: Text(
              '$number',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentOption extends StatelessWidget {
  const _PaymentOption({
    required this.value,
    required this.group,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onChanged,
  });

  final String value;
  final String group;
  final IconData icon;
  final String title;
  final String subtitle;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final active = value == group;
    final primary = Theme.of(context).colorScheme.primary;
    return GestureDetector(
      onTap: () => onChanged(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: active ? primary.withValues(alpha: 0.07) : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: active ? primary : AppColors.line,
            width: active ? 1.6 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: active ? primary : AppColors.muted),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(color: AppColors.muted, fontSize: 12.sp),
                  ),
                ],
              ),
            ),
            Icon(
              active
                  ? Icons.radio_button_checked_rounded
                  : Icons.radio_button_off_rounded,
              color: active ? primary : AppColors.subtle,
            ),
          ],
        ),
      ),
    );
  }
}
