import 'package:expens_tracker/export/export.dart';



class AppColors {
  AppColors._();

  // Brand
  static const Color primaryDark = Color(0xFF04342C);
  static const Color primary = Color(0xFF0F6E56);
  static const Color primaryLight = Color(0xFF9FE1CB);

  // Semantic
  static const Color danger = Color(0xFFA32D2D);
  static const Color success = Color(0xFF3B6D11);
  static const Color warning = Color(0xFF854F0B);

  static const Map<String, Color> categoryBackground = {
    'Food': Color(0xFFFAEEDA),
    'Transport': Color(0xFFE6F1FB),
    'Shopping': Color(0xFFFBEAF0),
    'Bills': Color(0xFFFAECE7),
    'Health': Color(0xFFFCEBEB),
    'Entertainment': Color(0xFFEEEDFE),
    'Other': Color(0xFFF1EFE8),
  };

  static const Map<String, Color> categoryForeground = {
    'Food': Color(0xFF633806),
    'Transport': Color(0xFF0C447C),
    'Shopping': Color(0xFF72243E),
    'Bills': Color(0xFF712B13),
    'Health': Color(0xFF791F1F),
    'Entertainment': Color(0xFF3C3489),
    'Other': Color(0xFF444441),
  };

  static Color categoryBg(String category) =>
      categoryBackground[category] ?? categoryBackground['Other']!;

  static Color categoryFg(String category) =>
      categoryForeground[category] ?? categoryForeground['Other']!;

  // Light theme surfaces
  static const Color lightBackground = Color(0xFFFAFAF8);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceMuted = Color(0xFFF1F1EE);
  static const Color lightBorder = Color(0xFFE3E2DD);
  static const Color lightTextPrimary = Color(0xFF1A1A18);
  static const Color lightTextSecondary = Color(0xFF66655F);
  static const Color lightTextMuted = Color(0xFF9C9B94);

  // Dark theme surfaces
  static const Color darkBackground = Color(0xFF14140F);
  static const Color darkSurface = Color(0xFF1E1E19);
  static const Color darkSurfaceMuted = Color(0xFF2A2A24);
  static const Color darkBorder = Color(0xFF3A3A33);
  static const Color darkTextPrimary = Color(0xFFF3F3EF);
  static const Color darkTextSecondary = Color(0xFFB4B3AB);
  static const Color darkTextMuted = Color(0xFF7C7B74);
}
