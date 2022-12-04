import 'package:bidex/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightTheme = _buildLightTheme();

ThemeData _buildLightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
        primary: AppColors.darkBlue,
        onPrimary: AppColors.darkBlue,
        secondary: AppColors.buttonLightBlue,
        error: AppColors.errorRed),
    // TODO: Add the text themes (103)

    textTheme: GoogleFonts.latoTextTheme(const TextTheme(
      overline: TextStyle(color: AppColors.darkBlue, letterSpacing: 0.8),
      caption: TextStyle(color: AppColors.darkBlue),
      bodyText2: TextStyle(color: AppColors.darkBlue),
      bodyText1: TextStyle(color: AppColors.darkBlue),
      subtitle2: TextStyle(color: AppColors.darkBlue),
      subtitle1: TextStyle(color: AppColors.darkBlue),
    )),

    // TODO: Add the icon themes (103)
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.black12.withOpacity(0.36)),
      hintStyle: TextStyle(
        color: Colors.black12.withOpacity(0.36),
        fontSize: 12,
      ),
      alignLabelWithHint: true,
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
              width: 0.5, color: AppColors.darkBlue.withOpacity(0.2))),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              BorderSide(width: 1, color: AppColors.blue.withOpacity(0.7))),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              BorderSide(width: 1, color: AppColors.errorRed.withOpacity(0.5))),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
              width: 0.5, color: AppColors.darkBlue.withOpacity(0.2))),
    ),
  );
}
