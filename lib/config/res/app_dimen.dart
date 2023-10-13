import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDimens {
  static const double _size1 = 1;
  static const double _size2 = 2;
  static const double _size3 = 3;
  static const double _size5 = 5;
  static const double _size10 = 10;
  static const double _size20 = 20;
  static const double _size30 = 30;
  static const double _size50 = 50;
  static const double _size40 = 40;
  static const double _size100 = 100;
  static const double _size200 = 200;

  static const Size designSize = Size(360, 690);
  static const double buttonRadius = 6;

  static const double _buttonTextSize = 15;
  static const double _labelEditTextSize = 14;
  static const double _smallTextSize = 12;
  static const double _tinyTextSize = 8;
  static const double _lightMemoTextSize = 10;
  static const double _memoTextSize = 12;
  static const double _mediumTextSize = 14;
  static const double _largeTextSize = 18;
  static const double _lightBiggestTextSize = 24;
  static const double _headerTitleSize = 25;
  static const double _biggestTextSize = 30;

  static const double _lightTinyStrokeWidth = 2;
  static const double _tinyStrokeWidth = 4;
  static const double _lightMemoStrokeWidth = 6;
  static const double _memoStrokeWidth = 8;
  static const double _smallStrokeWidth = 10;
  static const double _mediumStrokeWidth = 12;
  static const double _lightLargeStrokeWidth = 14;
  static const double _largeStrokeWidth = 16;
  static const double _lightBiggestStrokeWidth = 18;
  static const double _biggestStrokeWidth = 24;
  static const double _lightGiantStrokeWidth = 28;
  static const double _giantStrokeWidth = 32;

  static const double _smallSpacingVer = 12;
  static const double _aBitSpacingVer = 8;
  static const double _aBitSpacingHor = 8;
  static const double _mediumSpacingVer = 24;
  static const double _smallSpacingHor = 12;
  static const double _mediumSpacingHor = 24;
  static const double _buttonHeight = 50;

  static const double _logoSize = 200;
  static const double _iconTiniestSize = 4;
  static const double _iconLightTinySize = 8;
  static const double _iconTinySize = 12;
  static const double _iconSmallestSize = 16;
  static const double _iconSmallSize = 24;
  static const double _iconLightMediumSize = 30;
  static const double _iconMediumSize = 32;
  static const double _iconLargeSize = 42;
  static const double _iconBackSize = 16;
  static const double _defaultAppbarHeight = 90;
  static const double _defaultButtonHeight = 38;
  static const double _defaultOutlineButtonHeight = 25;

  static const double _headerTypeHeightRatio = 0.8;
  static const FontWeight fontWeightBold = FontWeight.w700;
  static const FontWeight fontWeightSemi = FontWeight.w500;
  static const double itemBorderSideWidth = 1;
  static const double gridFileHeight = kToolbarHeight * 3;
  static const double gridFileFooterHeight = kToolbarHeight * 0.8;
  static const FontWeight semiBold = FontWeight.w600;
  static const double _coverArtHeightSize = 200;

  static double get labelEditTextSize => _labelEditTextSize.sp;

  static double get buttonTextSize => _buttonTextSize.sp;

  static double get tinyTextSize => _tinyTextSize.sp;

  static double get lightMemoTextSize => _lightMemoTextSize.sp;

  static double get memoTextSize => _memoTextSize.sp;

  static double get smallTextSize => _smallTextSize.sp;

  static double get mediumTextSize => _mediumTextSize.sp;

  static double get largeTextSize => _largeTextSize.sp;

  static double get headerTitleSize => _headerTitleSize.h;

  static double get biggestTextSize => _biggestTextSize.sp;

  static double get lightBiggestTextSize => _lightBiggestTextSize.sp;

  static double get lightTinyStrokeWidth => _lightTinyStrokeWidth.sp;

  static double get tinyStrokeWidth => _tinyStrokeWidth.sp;

  static double get lightMemoStrokeWidth => _lightMemoStrokeWidth.sp;

  static double get memoStrokeWidth => _memoStrokeWidth.sp;

  static double get smallStrokeWidth => _smallStrokeWidth.sp;

  static double get mediumStrokeWidth => _mediumStrokeWidth.sp;

  static double get lightLargeStrokeWidth => _lightLargeStrokeWidth.sp;

  static double get largeStrokeWidth => _largeStrokeWidth.sp;

  static double get biggestStrokeWidth => _biggestStrokeWidth.sp;

  static double get lightBiggestStrokeWidth => _lightBiggestStrokeWidth.sp;

  static double get lightGiantStrokeWidth => _lightGiantStrokeWidth.sp;

  static double get giantStrokeWidth => _giantStrokeWidth.sp;

  static double get logoSize => _logoSize.h;

  static double get iconLargeSize => _iconLargeSize.h;

  static double get iconBackSize => _iconBackSize.r;
  static double get defaultAppbarHeight => _defaultAppbarHeight.h;
  static double get defaultButtonHeight => _defaultButtonHeight.h;
  static double get defaultOutlineButtonHeight => _defaultOutlineButtonHeight.h;

  static double get iconMediumSize => _iconMediumSize.h;

  static double get iconLightMediumSize => _iconLightMediumSize.h;

  static double get iconSmallSize => _iconSmallSize.h;

  static double get iconSmallestSize => _iconSmallestSize.h;

  static double get iconTinySize => _iconTinySize.h;

  static double get iconLightTinySize => _iconLightTinySize.r;

  static double get iconTiniestSize => _iconTiniestSize.r;

  /// 6.w
  static double get aBitSpacingVer => _aBitSpacingVer.h;

  /// 6.w
  static double get aBitSpacingHor => _aBitSpacingHor.w;

  /// 12.w
  static double get smallSpacingVer => _smallSpacingVer.h;

  /// 24.w
  static double get mediumSpacingVer => _mediumSpacingVer.h;

  /// 12.w
  static double get smallSpacingHor => _smallSpacingHor.w;

  /// 24.w
  static double get mediumSpacingHor => _mediumSpacingHor.w;

  static double get buttonHeight => _buttonHeight;

  static double get headerTypeHeight =>
      (kToolbarHeight * _headerTypeHeightRatio).h;

  static double get coverArtHeightSize => _coverArtHeightSize.h;

  static double get size1 => _size1;

  static double get size2 => _size2;

  static double get size3 => _size3;

  static double get size5 => _size5;

  static double get size10 => _size10;

  static double get size20 => _size20;

  static double get size30 => _size30;

  static double get size40 => _size40;

  static double get size50 => _size50;

  static double get size100 => _size100;

  static double get size200 => _size200;
}
