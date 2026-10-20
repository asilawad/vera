import 'package:flutter/material.dart';
import 'package:souqna_anaqa/utils/app_colors.dart';
import 'package:souqna_anaqa/utils/app_dimens.dart';
import 'package:souqna_anaqa/utils/app_strings.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader(this.title, {super.key, this.subtitle, this.onMore});

  final String title;
  final String? subtitle;
  final VoidCallback? onMore;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
        AppSpacing.page,
        AppSizes.homeSectionTopPadding,
        AppSpacing.page,
        AppSizes.homeSectionBottomPadding,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
                  ),
              ],
            ),
          ),
          if (onMore != null)
            TextButton(
              onPressed: onMore,
              child: Text(
                AppStrings.seeAll,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
