import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const primary = Color(0xFF12CDD9);
  static const primaryBackgroundShade = Color(0xFF05E9F7);
  static const secondary = Color(0xFFFF8700);
  static const blueHighlightColor = Color(0xFF3E97FF);
  static const blueHighlightBackgroundShade = Color(0xFFB8E3DB);
  static const blueHighlightBackgroundShade2 = Color(0xFFE2F1FF);
  static const bottomBarSelectedColor = primary;
  static const tabLabelBoxColor = Color(0xFF252836);

  static MaterialColor primaryMaterialColor =
      MaterialColor(primary.value, const {
        50: primary,
        100: primary,
        200: primary,
        300: primary,
        400: primary,
        500: primary,
        600: primary,
        700: primary,
        800: primary,
        900: primary,
      });

  static const cardBackgroundColor = Color(0xFF252836);
  static const greenColor = Color(0xFF50CD89);
  static const greenBackgroundShade = Color(0xFFB3FADE);
  static const greenBackgroundShade2 = Color(0xFFEFFDF7);
  static const pendingColor = Color(0xFFFFA337);
  static const pendingBackgroundShade = Color(0xFFFFF5E9);
  static const pendingBackgroundShade2 = Color(0xFFFFE0AD);
  static const kHintColorText = Color(0xFF7E8299);
  static const kColorError = Color(0xFF720707);
  static const kColorBackground = Color(0xFF1F1D2B);
  static const favouriteIcon = Color(0xFFFF69B4);
  static const kColorBackgroundSecondary = Color(0xFFF9F9F9);
  static const kColorButtonPrimary = primary;
  static get kColorButtonSecondary => secondary;
  static const kColorOutlineButton = Color(0xFFFAFAFA);
  static const kColorOutlineButtonBorder = Color(0xFFECEBEC);
  static const kColorDottedBorder = Color(0xFFD8D8E5);
  static const kCheckBoxBorder = Color(0xFFBFBBBD);
  static const kBorderColor = Color(0xFFE1E3EA);
  static const kInputDecorationIconColor = Color(0xFF7E8299);
  static const kColorDivider = kColorOutlineButtonBorder;
  static const kChipSelectedColor = primary;
  static const kChipUnselectedColor = kColorOutlineButton;
}
