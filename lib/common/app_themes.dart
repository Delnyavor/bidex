import 'package:bidex/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightTheme = _buildLightTheme();

ThemeData _buildLightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    // colorScheme: base.colorScheme.copyWith(
    //     primary: AppColors.darkBlue,
    //     onPrimary: AppColors.darkBlue,
    //     secondary: AppColors.buttonLightBlue,
    //     error: AppColors.errorRed),

    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.blue),

    // TODO: Add the text themes
    textTheme: GoogleFonts.dmSansTextTheme(
        base.textTheme.apply(bodyColor: Colors.black)),

    iconTheme: base.iconTheme.copyWith(
      color: Colors.black,
      fill: 0.5,
    ),

    // TODO: Add the icon themes
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
