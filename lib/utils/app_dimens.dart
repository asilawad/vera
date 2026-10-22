import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSpacing {
  AppSpacing._();

  static double get xs => 4.w;
  static double get sm => 8.w;
  static double get md => 12.w;
  static double get lg => 16.w;
  static double get xl => 24.w;
  static double get xxl => 32.w;
  static double get page => 20.w;
  static double get compact => 10.w;
  static double get micro => 3.w;
  static double get xxs => 2.w;
  static double get barVertical => 14.w;
  static double get navigationIndicatorHorizontal => 14.w;
}

class AppRadius {
  AppRadius._();

  static const double none = 0;
  static double get sm => 8.r;
  static double get md => 14.r;
  static double get lg => 20.r;
  static double get pill => 999.r;
  static double get chip => md;
  static double get card => lg;
  static double get badge => 10.r;
  static const double navItem = 24;
}

class AppSizes {
  AppSizes._();

  static double get icon => 24.w;
  static double get compactIcon => 18.w;
  static double get smallIcon => 16.w;
  static double get ratingStar => 14.w;
  static double get cartSpinner => 18.w;
  static const double cartBadgeRestScale = 1;
  static const double cartBadgeBumpScale = 1.15;
  static const double checkBadgeSize = 40;
  static const double checkIconScale = 0.6;
  static double get productPriceFontSize => 22;
  static double get galleryIndicatorActiveWidth => 20.w;
  static double get galleryIndicatorWidth => 7.w;
  static double get galleryIndicatorHeight => 7.h;
  static double get sizeOptionMinWidth => 52.w;
  static double get sizeOptionHeight => 46.h;
  static double get colorSwatch => 42.w;
  static double get reviewStar => 38.w;
  static double get reviewProgressHeight => 6.h;
  static double get relatedProductWidth => 160.w;
  static double get bottomBarShadowBlur => 20.r;
  static double get borderWidth => 2.w;
  static double get buttonHeight => 48.h;
  static double get galleryHeight => 375.h;
  static double get chipHeight => 40.h;
  static double get chipIcon => 18.w;
  static double get dot => 6.w;
  static double get dotActive => 18.w;
  static double get appBarHeight => 56.h;
  static double get cardShadowBlur => 12.r;
  static double get discountCompactFont => 11;
  static double get favoriteButton => 36.w;
  static const double favoritePopScale = 1.15;
  static const double favoriteIconScale = 0.52;
  static double get productCategoryFont => 11;
  static double get productNameFont => 14;
  static double get productPriceFont => 14;
  static double get productRatingFont => 12;
  static double get productStockFont => 12;
  static const double productGridImageAspect = 164 / 195;
  static const double productRailImageAspect = 168 / 220;
  static double get skeletonTextHeight => 14.h;
  static double get bannerSkeletonHeight => 160.h;
  static double get categorySkeletonWidth => 80.w;
  static double get reviewSkeletonHeight => 96.h;
  static double get cartSkeletonImage => 72.w;
  static double get cartSkeletonSummaryHeight => 160.h;
  static double get orderSkeletonStatusHeight => 100.h;
  static double get homeHeaderLogo => 48.r;
  static double get homeBellButton => 44.r;
  static double get homeSearchHeight => 54.h;
  static double get homeBannerPageGap => 5.w;
  static double get homeBannerTopSpace => 14.h;
  static double get homeBannerDotsGap => 10.h;
  static double get homeBannerPageScale => 0.06;
  static double get homeBannerMinScale => 0.92;
  static double get homeBannerMaxScale => 1;
  static double get homeBannerPageAspect => 16 / 7;
  static double get homeBannerMaxHeightFactor => 0.42;
  static double get homeBannerTabletFraction => 0.62;
  static double get homeBannerDesktopFraction => 0.46;
  static double get homeBannerMobileFraction => 0.9;
  static double get homeBannerPageTabletPadding => 10.w;
  static double get homeCardImageTextGap => 10.h;
  static double get homeCardPadding => 10.w;
  static double get homeProductRailHeight => 360.h;
  static double get homeProductRailWidth => 168.w;
  static double get homeHeaderVerticalPadding => 14.h;
  static double get homeSectionTopPadding => 26.h;
  static double get homeSectionBottomPadding => 14.h;
  static double get homeSearchVerticalPadding => 12.h;
  static double get homeSearchBottomPadding => 4.h;
  static double get homeCarouselShadowBlur => 14.r;
  static double get homeCarouselShadowOffset => 5.h;
  static double get homeProductImageHeight => 188.h;
  static double get homeBannerDotGap => 3.w;
  static double get sectionHeaderSubtitleFont => 12.5;
  static double get sectionHeaderTitleFont => 19;
  static double get productNameLineHeight => 1.4;
  static double get productHeaderInset => 10.w;
  static const double bottomNavigationHeight = 68;
  static const double bottomNavigationMaxWidth = 560;
  static double get productDetailsBottomPadding => 140.h;
  static double get productDetailsDesktopBottomPadding => 120.h;
  static double get glassIconButton => 44.r;
  static double get navItemLabelFont => 10.5;
  static const double navSelectedOpacity = 0.18;

  static const int productGridSkeletonCount = 6;
  static const double skeletonProductTitleWidth = 0.75;
  static const double skeletonProductPriceWidth = 0.4;
  static const double skeletonDetailTitleWidth = 0.8;
  static const double skeletonDetailShortWidth = 0.5;
  static const double skeletonDetailLineWidth = 0.9;
  static const double skeletonBannerAspectRatio = 2.2;
  static const int skeletonCategoryCount = 5;
  static const int skeletonProductRowCount = 3;
  static const int skeletonReviewCount = 5;
  static const int skeletonCartCount = 3;
  static const int skeletonOrderItemCount = 4;
  static const int skeletonStoreTextLines = 4;
  static const int skeletonDetailOptionCount = 3;
  static const int homeFeaturedMaxRows = 3;
  static const int homeSkeletonCategoryCount = 4;
  static const int homeSkeletonProductGridCount = 4;
  static const int noonHour = 12;
  static const int eveningHour = 18;
  static const int homeCategoryTabIndex = 1;
  static const int productNameMaxLines = 2;
  static const tabletBreakpoint = 600.0;
  static const twoPaneWidth = 840.0;
  static const desktopBreakpoint = 1024.0;

  /// Reserved width beside the cart label: stepper (40 + 34 + 40),
  /// row gap (12), button padding (16 + 24), icon (18), and icon-label gap (8).
  static const addToCartLabelReservedWidth = 114 + 12 + 16 + 24 + 18 + 8;
}
