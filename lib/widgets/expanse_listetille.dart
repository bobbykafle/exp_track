import 'package:expens_tracker/export/export.dart';


class ExpenseListTile extends StatelessWidget {
  const ExpenseListTile({
    super.key,
    required this.expense,
    required this.dateLabel,
    this.onTap,
  });

  final Expense expense;
  final String dateLabel;
  final VoidCallback? onTap;

  static IconData _iconFor(ExpenseCategory category) {
    switch (category) {
      case ExpenseCategory.food:
        return Icons.ramen_dining_outlined;
      case ExpenseCategory.transport:
        return Icons.directions_car_outlined;
      case ExpenseCategory.shopping:
        return Icons.shopping_bag_outlined;
      case ExpenseCategory.bills:
        return Icons.receipt_long_outlined;
      case ExpenseCategory.health:
        return Icons.favorite_outline;
      case ExpenseCategory.entertainment:
        return Icons.movie_outlined;
      case ExpenseCategory.other:
        return Icons.more_horiz_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bg = AppColors.categoryBg(expense.category.label);
    final fg = AppColors.categoryFg(expense.category.label);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        child: Row(
          children: [
            Container(
              width: AppSpacing.categoryIconSize - 8,
              height: AppSpacing.categoryIconSize - 8,
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              ),
              child: Icon(_iconFor(expense.category), color: fg, size: AppSpacing.iconMd),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    expense.title,
                    style: AppTextStyles.bodyLarge.copyWith(color: Theme.of(context).colorScheme.onSurface),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text('${expense.category.label} · $dateLabel', style: AppTextStyles.bodySmall),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              '-\$${expense.amount.toStringAsFixed(2)}',
              style: AppTextStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
