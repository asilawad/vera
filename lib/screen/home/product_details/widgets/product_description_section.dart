import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:souqna_anaqa/utils/app_colors.dart';
import 'package:souqna_anaqa/utils/app_strings.dart';

class ProductDescriptionSection extends StatelessWidget {
  const ProductDescriptionSection({super.key, required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          AppStrings.description,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.sp),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(
            color: AppColors.muted,
            height: 1.8,
            fontSize: 14.5.sp,
          ),
        ),
      ],
    );
  }
}
