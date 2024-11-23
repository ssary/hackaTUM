import 'package:flutter/material.dart';
import 'package:frontend/constants/app_spacing.dart';
import 'colors.dart';
import 'typography.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      // Set the primary color
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: Colors.white,
      canvasColor: Colors.white,

      // AppBar theme
      appBarTheme: const AppBarTheme(
        color: AppColors.primaryColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),

      // Text theme
      textTheme: AppTypography.textTheme,

      // Button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.primaryColor, // Background color
          textStyle: const TextStyle(color: Colors.white), // Text color
          padding: const EdgeInsets.symmetric(
              vertical: Spacing.p8, horizontal: Spacing.p24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),

      // Input field decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightGray,
        contentPadding: const EdgeInsets.symmetric(
            vertical: Spacing.p16, horizontal: Spacing.p8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Spacing.p8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Spacing.p8),
          borderSide:
              const BorderSide(color: AppColors.primaryColor, width: 1.5),
        ),
      ),

      // Card theme
      cardTheme: CardTheme(
        color: Colors.white,
        shadowColor: Colors.grey.withOpacity(0.2),
        elevation: 4,
        margin:
            const EdgeInsets.symmetric(vertical: Spacing.p8, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: Colors.black,
        selectedLabelStyle: AppTypography.textTheme.displaySmall,
        unselectedLabelStyle: AppTypography.textTheme.displaySmall,
        showUnselectedLabels: true,
      ),

      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.primaryColor.withOpacity(0.1),
          hintStyle: AppTypography.textTheme.headlineSmall!.copyWith(
            color: const Color.fromRGBO(117, 117, 117, 1),
          ),
          labelStyle: AppTypography.textTheme.headlineSmall,
          contentPadding: const EdgeInsets.symmetric(
            vertical: Spacing.p16,
            horizontal: Spacing.p8,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Spacing.p8),
            borderSide: const BorderSide(
              color: AppColors.primaryColor,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Spacing.p8),
            borderSide: const BorderSide(
              color: AppColors.primaryColor,
              width: 1.5,
            ),
          ),
        ),
        menuStyle: MenuStyle(
          backgroundColor: WidgetStateProperty.all(AppColors.lightGray),
          surfaceTintColor: WidgetStateProperty.all(AppColors.lightGray),
          elevation: WidgetStateProperty.all(4.0),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(
                vertical: Spacing.p8, horizontal: Spacing.p8),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Spacing.p8),
            ),
          ),
        ),
      ),
    );
  }
}
