# Flutter Project Guidelines

## File Size
- Keep every file at or below 200 lines; aim for approximately 50 lines.
- Extract larger implementations into focused files.

## Widgets and UI
- Never create widgets with helper methods such as `Widget _buildX()`.
- Implement each reusable or standalone widget as a dedicated `StatelessWidget` class in its own file.
- Do not hardcode user-facing strings, colors, or magic numbers.
- Use `AppStrings` for text, `AppColors` and `Theme.of(context)` for colors, and the existing `AppSpacing`, `AppSizes`, and `AppRadius` constants for dimensions and spacing.
- Use `EdgeInsetsDirectional` instead of directional-agnostic insets so layouts support RTL.

## Behavior and State
- Preserve existing behavior and business logic when making UI or structural changes.
- Keep existing GetX usage and patterns as they are; do not replace or refactor state management.

## Validation
- After every change, run `dart format .` and `flutter analyze`.
- Fix any new warnings introduced by the change.
