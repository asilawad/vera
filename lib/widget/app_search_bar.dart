import 'package:flutter/material.dart';

import 'package:souqna_anaqa/utils/app_colors.dart';
import 'package:souqna_anaqa/utils/app_dimens.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({
    super.key,
    required this.hint,
    this.onTap,
    this.readOnly = true,
    this.controller,
    this.onChanged,
  });

  final String hint;
  final VoidCallback? onTap;
  final bool readOnly;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
        AppSpacing.page,
        AppSpacing.md,
        AppSpacing.page,
        AppSpacing.xs,
      ),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        onTap: onTap,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.muted),
          filled: true,
          fillColor: AppColors.surface,
          suffixIcon: const Icon(Icons.search_rounded),
          suffixIconColor: AppColors.muted,
          constraints: BoxConstraints(minHeight: AppSizes.homeSearchHeight),
          contentPadding: EdgeInsetsDirectional.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.card),
            borderSide: const BorderSide(color: AppColors.line),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.card),
            borderSide: const BorderSide(color: AppColors.line),
          ),
        ),
      ),
    );
  }
}
