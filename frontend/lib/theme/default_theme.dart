import 'package:flutter/material.dart';

class AppTheme {
  ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      visualDensity: VisualDensity.compact,
      colorScheme: const ColorScheme(
        background: Color(0xFFF9FAEF),
        brightness: Brightness.light,
        error: Color(0xFFBA1A1A),
        errorContainer: Color(0xFFFFDAD6),
        inversePrimary: Color(0xFFADD28E),
        inverseSurface: Color(0xFF2E312A),
        onBackground: Color(0xFF191D16),
        onError: Color(0xFFFFFFFF),
        onErrorContainer: Color(0xFF410002),
        onInverseSurface: Color(0xFFF0F2E7),
        onPrimary: Color(0xFFFFFFFF),
        onPrimaryContainer: Color(0xFF0B2000),
        onSecondary: Color(0xFFFFFFFF),
        onSecondaryContainer: Color(0xFF310048),
        onSurface: Color(0xFF191D16),
        onSurfaceVariant: Color(0xFF44483E),
        onTertiary: Color(0xFFFFFFFF),
        onTertiaryContainer: Color(0xFF002020),
        outline: Color(0xFF74796D),
        outlineVariant: Color(0xFFC4C8BB),
        primary: Color(0xFF59803C),
        primaryContainer: Color(0xFFBCF293),
        scrim: Color(0xFF000000),
        secondary: Color(0xFF6A5373),
        secondaryContainer: Color(0xFFF7D9FF),
        shadow: Color(0xFF000000),
        surface: Color(0xFFF9FAEF),
        surfaceContainerHighest: Color(0xFFE2E3D9),
        surfaceTint: Color(0xFF47672F),
        tertiary: Color(0xFF386665),
        tertiaryContainer: Color(0xFFBBECEA),
      ),
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
          color: Color(0xFFFFFFFF),
          fontFamily: 'Roboto',
          fontSize: 24,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
        ),
        toolbarTextStyle: TextStyle(
          color: Color(0xFFFFFFFF),
          fontFamily: 'Roboto',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedLabelStyle: TextStyle(
          color: Color(0xFFFFFFFF),
          fontFamily: 'Roboto',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
        ),
        unselectedLabelStyle: TextStyle(
          color: Color(0xFFFFFFFF),
          fontFamily: 'Roboto',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
        ),
      ),
      buttonTheme: ButtonThemeData(
        alignedDropdown: false,
        height: 36,
        layoutBehavior: ButtonBarLayoutBehavior.padded,
        minWidth: 88,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
        textTheme: ButtonTextTheme.normal,
      ),
      canvasColor: const Color(0xFFF9FAEF),
      cardColor: const Color(0xFFF9FAEF),
      dialogBackgroundColor: const Color(0xFFF9FAEF),
      disabledColor: const Color(0x61000000),
      dividerColor: const Color(0x1F191D16),
      focusColor: const Color(0x1F000000),
      highlightColor: const Color(0x66BCBCBC),
      hintColor: const Color(0x99000000),
      hoverColor: const Color(0x0A000000),
      iconTheme: const IconThemeData(
        color: Color(0xDD000000),
      ),
      indicatorColor: const Color(0xFFFFFFFF),
      primaryColor: const Color(0xFF59803C),
      primaryColorDark: const Color(0xFF1976D2),
      primaryColorLight: const Color(0xFFBBDEFB),
      primaryIconTheme: const IconThemeData(
        color: Color(0xFFFFFFFF),
      ),
      scaffoldBackgroundColor: const Color(0xFFF9FAEF),
      secondaryHeaderColor: const Color(0xFFE3F2FD),
      shadowColor: const Color(0xFF000000),
      splashColor: const Color(0x66C8C8C8),
      splashFactory: InkRipple.splashFactory,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: Color(0xFF191D16),
          fontFamily: 'Sora_regular',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
        ),
        bodyMedium: TextStyle(
          color: Color(0xFF191D16),
          fontFamily: 'Sora_regular',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
        ),
        bodySmall: TextStyle(
          color: Color(0xFF191D16),
          fontFamily: 'Sora_regular',
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
        ),
        displayLarge: TextStyle(
          color: Color(0xFF191D16),
          fontFamily: 'Sora_300',
          fontSize: 96,
          fontWeight: FontWeight.w300,
          letterSpacing: -1.5,
        ),
        displayMedium: TextStyle(
          color: Color(0xFF191D16),
          fontFamily: 'Sora_300',
          fontSize: 60,
          fontWeight: FontWeight.w300,
          letterSpacing: -0.5,
        ),
        displaySmall: TextStyle(
          color: Color(0xFF191D16),
          fontFamily: 'Sora_regular',
          fontSize: 48,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
        ),
        headlineLarge: TextStyle(
          color: Color(0xFF191D16),
          fontFamily: 'Sora_regular',
          fontSize: 40,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
        ),
        headlineMedium: TextStyle(
          color: Color(0xFF191D16),
          fontFamily: 'Sora_regular',
          fontSize: 34,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
        ),
        headlineSmall: TextStyle(
          color: Color(0xFF191D16),
          fontFamily: 'Sora_regular',
          fontSize: 24,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
        ),
        labelLarge: TextStyle(
          color: Color(0xFF191D16),
          fontFamily: 'Sora_500',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
        ),
        labelMedium: TextStyle(
          color: Color(0xFF191D16),
          fontFamily: 'Sora_regular',
          fontSize: 11,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.5,
        ),
        labelSmall: TextStyle(
          color: Color(0xFF191D16),
          fontFamily: 'Sora_regular',
          fontSize: 10,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.5,
        ),
        titleLarge: TextStyle(
          color: Color(0xFF191D16),
          fontFamily: 'Sora_500',
          fontSize: 20,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        ),
        titleMedium: TextStyle(
          color: Color(0xFF191D16),
          fontFamily: 'Sora_regular',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.15,
        ),
        titleSmall: TextStyle(
          color: Color(0xFF191D16),
          fontFamily: 'Sora_500',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
      ),
      primaryTextTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: Color(0xFFF9FAEF),
          fontFamily: '.AppleSystemUIFont',
        ),
        bodyMedium: TextStyle(
          color: Color(0xFFF9FAEF),
          fontFamily: '.AppleSystemUIFont',
        ),
        bodySmall: TextStyle(
          color: Color(0xFFF9FAEF),
          fontFamily: '.AppleSystemUIFont',
        ),
        displayLarge: TextStyle(
          color: Color(0xFFF9FAEF),
          fontFamily: '.AppleSystemUIFont',
        ),
        displayMedium: TextStyle(
          color: Color(0xFFF9FAEF),
          fontFamily: '.AppleSystemUIFont',
        ),
        displaySmall: TextStyle(
          color: Color(0xFFF9FAEF),
          fontFamily: '.AppleSystemUIFont',
        ),
        headlineLarge: TextStyle(
          color: Color(0xFFF9FAEF),
          fontFamily: '.AppleSystemUIFont',
        ),
        headlineMedium: TextStyle(
          color: Color(0xFFF9FAEF),
          fontFamily: '.AppleSystemUIFont',
        ),
        headlineSmall: TextStyle(
          color: Color(0xFFF9FAEF),
          fontFamily: '.AppleSystemUIFont',
        ),
        labelLarge: TextStyle(
          color: Color(0xFFF9FAEF),
          fontFamily: '.AppleSystemUIFont',
        ),
        labelMedium: TextStyle(
          color: Color(0xFFF9FAEF),
          fontFamily: '.AppleSystemUIFont',
        ),
        labelSmall: TextStyle(
          color: Color(0xFFF9FAEF),
          fontFamily: '.AppleSystemUIFont',
        ),
        titleLarge: TextStyle(
          color: Color(0xFFF9FAEF),
          fontFamily: '.AppleSystemUIFont',
        ),
        titleMedium: TextStyle(
          color: Color(0xFFF9FAEF),
          fontFamily: '.AppleSystemUIFont',
        ),
        titleSmall: TextStyle(
          color: Color(0xFFF9FAEF),
          fontFamily: '.AppleSystemUIFont',
        ),
      ),
      tabBarTheme: const TabBarTheme(
        labelStyle: TextStyle(
          color: Color(0xFFFFFFFF),
          fontFamily: 'Roboto',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
        unselectedLabelStyle: TextStyle(
          color: Color(0xFFFFFFFF),
          fontFamily: 'Roboto',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
      ),
      typography: Typography.material2021(platform: TargetPlatform.iOS),
      applyElevationOverlayColor: false,
      platform: TargetPlatform.macOS,
      unselectedWidgetColor: const Color(0x8A000000),
      inputDecorationTheme: const InputDecorationTheme(
        alignLabelWithHint: false,
        filled: false,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        isCollapsed: false,
        isDense: false,
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
