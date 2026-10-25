import 'package:flutter/material.dart';

import 'package:souqna_anaqa/utils/app_strings.dart';
import 'package:souqna_anaqa/utils/helpers.dart';
import 'package:souqna_anaqa/utils/responsive.dart';

class CheckoutConfirmButton extends StatelessWidget {
  const CheckoutConfirmButton({
    super.key,
    required this.total,
    required this.onPressed,
  });

  final double total;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        14,
        20,
        14 + MediaQuery.paddingOf(context).bottom,
      ),
      color: Colors.white,
      child: MaxWidthBox(
        maxWidth: Responsive.readingMaxWidth,
        child: FilledButton(
          onPressed: onPressed,
          child: Text(
            AppStrings.confirmOrder.replaceAll('{amount}', Fmt.money(total)),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
