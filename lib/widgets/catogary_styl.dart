import 'package:expens_tracker/export/export.dart';


class CategoryStyle {
  const CategoryStyle({
    required this.icon,
    required this.shortLabel,
    required this.accent,
  });

  final FaIconData icon;
  final String shortLabel;

 
  final Color accent;

  static CategoryStyle of(ExpenseCategory category) {
    switch (category) {
      case ExpenseCategory.food:
        return const CategoryStyle(icon: FontAwesomeIcons.bowlFood, shortLabel: 'Food', accent: Color(0xFFEF9F27));
      case ExpenseCategory.transport:
        return const CategoryStyle(icon: FontAwesomeIcons.carSide, shortLabel: 'Transport', accent: Color(0xFF378ADD));
      case ExpenseCategory.shopping:
        return const CategoryStyle(icon: FontAwesomeIcons.bagShopping, shortLabel: 'Shopping', accent: Color(0xFFD4537E));
      case ExpenseCategory.bills:
        return const CategoryStyle(icon: FontAwesomeIcons.fileInvoiceDollar, shortLabel: 'Bills', accent: Color(0xFFD85A30));
      case ExpenseCategory.health:
        return const CategoryStyle(icon: FontAwesomeIcons.heartPulse, shortLabel: 'Health', accent: Color(0xFFE24B4A));
      case ExpenseCategory.entertainment:
        return const CategoryStyle(icon: FontAwesomeIcons.film, shortLabel: 'Fun', accent: Color(0xFF7F77DD));
      case ExpenseCategory.other:
        return const CategoryStyle(icon: FontAwesomeIcons.ellipsis, shortLabel: 'Other', accent: Color(0xFF888780));
    }
  }
}