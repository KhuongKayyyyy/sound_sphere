import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';

class AppTheme {
  // static Color primaryColor = const Color(0xFFFFD1DC);
  static ThemeData get theme {
    return ThemeData(
      primaryColor: AppColor.primaryColor,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white.withOpacity(0.9),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: AppColor.secondaryColor,
      ),
    );
  }
}
