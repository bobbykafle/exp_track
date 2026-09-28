import 'package:expens_tracker/export/export.dart';

class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  const AppColorsExtension({
    required this.primaryBlue,
    required this.lightBlue,
    required this.white,
    required this.black,
    required this.offWhite,
    required this.cream,
    required this.reacher,
    required this.hintColor,
  });

  final Color primaryBlue;
  final Color lightBlue;
  final Color white;
  final Color black;
  final Color offWhite;
  final Color cream;
  final Color reacher;
  final Color hintColor;

  @override
  AppColorsExtension copyWith({
    Color? primaryBlue,
    Color? lightBlue,
    Color? white,
    Color? black,
    Color? offWhite,
    Color? cream,
    Color? reacher,
    Color? hintColor,
  }) {
    return AppColorsExtension(
      primaryBlue: primaryBlue ?? this.primaryBlue,
      lightBlue: lightBlue ?? this.lightBlue,
      white: white ?? this.white,
      black: black ?? this.black,
      offWhite: offWhite ?? this.offWhite,
      cream: cream ?? this.cream,
      reacher: reacher ?? this.reacher,
      hintColor: hintColor ?? this.hintColor,
    );
  }

  @override
  AppColorsExtension lerp(ThemeExtension<AppColorsExtension>? other, double t) {
    if (other is! AppColorsExtension) return this;
    return AppColorsExtension(
      primaryBlue: Color.lerp(primaryBlue, other.primaryBlue, t)!,
      lightBlue: Color.lerp(lightBlue, other.lightBlue, t)!,
      white: Color.lerp(white, other.white, t)!,
      black: Color.lerp(black, other.black, t)!,
      offWhite: Color.lerp(offWhite, other.offWhite, t)!,
      cream: Color.lerp(cream, other.cream, t)!,
      reacher: Color.lerp(reacher, other.reacher, t)!,
      hintColor: Color.lerp(hintColor, other.hintColor, t)!,
    );
  }
}

class AppTheme {
  AppTheme._();

  // Custom brand colors (LIGHT mode)
  static const _lightColors = AppColorsExtension(
    primaryBlue: Color(0xFF005CE3),
    lightBlue: Color(0xFF2886F8),
    white: Color(0xFFFFFFFF),
    black: Color(0xFF000000),
    offWhite: Color(0xFFFAF9F6),
    cream: Color(0xFFFDF6EC),
    reacher: Color(0xFFC7DEFA),
    hintColor: Color(0xFF94A3B8),
  );

  // Custom brand colors (DARK mode)
  static const _darkColors = AppColorsExtension(
    primaryBlue: Color(0xFF4B9BFF),
    lightBlue: Color(0xFF6FA8F5),
    white: Color(0xFF000000), 
    black: Color(0xFFFFFFFF),
    offWhite: Color(0xFF1E1E1E),
    cream: Color(0xFF2A2622),
    reacher: Color(0xFF1B3A5C),
    hintColor: Color(0xFF64748B),
  );

  static final ThemeData light = _build(Brightness.light, _lightColors);
  static final ThemeData dark = _build(Brightness.dark, _darkColors);

  static ThemeData _build(Brightness brightness, AppColorsExtension appColors) {
    final isDark = brightness == Brightness.dark;

    final background = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final surfaceMuted = isDark ? AppColors.darkSurfaceMuted : AppColors.lightSurfaceMuted;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final textPrimary = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final textSecondary = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: AppColors.primary,
      onPrimary: Colors.white,
      secondary: AppColors.primaryLight,
      onSecondary: AppColors.primaryDark,
      error: AppColors.danger,
      onError: Colors.white,
      surface: surface,
      onSurface: textPrimary,
    );

    return ThemeData(
      brightness: brightness,
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,
      fontFamily: AppTextStyles.fontFamily,
      textTheme: TextTheme(
        displayLarge: AppTextStyles.displayLarge.copyWith(color: textPrimary),
        displayMedium: AppTextStyles.displayMedium.copyWith(color: textPrimary),
        headlineLarge: AppTextStyles.h1.copyWith(color: textPrimary),
        headlineMedium: AppTextStyles.h2.copyWith(color: textPrimary),
        headlineSmall: AppTextStyles.h3.copyWith(color: textPrimary),
        bodyLarge: AppTextStyles.bodyLarge.copyWith(color: textPrimary),
        bodyMedium: AppTextStyles.bodyMedium.copyWith(color: textSecondary),
        bodySmall: AppTextStyles.bodySmall.copyWith(color: textSecondary),
        labelLarge: AppTextStyles.button.copyWith(color: textPrimary),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: AppTextStyles.h1.copyWith(color: textPrimary),
        iconTheme: IconThemeData(color: textPrimary),
      ),
      cardTheme: CardThemeData(
        color: surfaceMuted,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
      ),
      dividerTheme: DividerThemeData(color: border, thickness: 0.6, space: 0),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          borderSide: BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          borderSide: BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          borderSide: const BorderSide(color: AppColors.danger),
        ),
        labelStyle: AppTextStyles.bodyMedium.copyWith(color: textSecondary),
        hintStyle: AppTextStyles.bodyMedium.copyWith(
          color: textSecondary.withValues(alpha: 0.6),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryDark,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(AppSpacing.controlHeight),
          textStyle: AppTextStyles.button,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          ),
          elevation: 0,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryDark,
        foregroundColor: Colors.white,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: surfaceMuted,
        labelStyle: AppTextStyles.bodySmall.copyWith(color: textSecondary),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.xs),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
          side: BorderSide(color: border),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      extensions: [appColors],
    );
  }
}

extension AppThemeExtension on BuildContext {
  AppColorsExtension get colors => Theme.of(this).extension<AppColorsExtension>()!;
  TextTheme get textTheme => Theme.of(this).textTheme;
}