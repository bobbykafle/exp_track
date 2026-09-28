import 'package:expens_tracker/export/export.dart';


class MonthlySummaryCard extends StatelessWidget {
  const MonthlySummaryCard({
    super.key,
    required this.total,
    required this.monthLabel,
    this.comparisonLabel,
    required this.isIncrease,
  });

  final double total;
  final String monthLabel;
  final bool isIncrease;
  final String? comparisonLabel;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primaryDark,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Spent in $monthLabel',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.primaryLight.withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            
            Text(
              '\$${total.toStringAsFixed(2)}',
              style: AppTextStyles.displayLarge.copyWith(
                color: AppColors.lightBorder,
              ),
            ),
            
            if (comparisonLabel != null) ...[
              const SizedBox(height: AppSpacing.md),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FaIcon(
                    isIncrease ? FontAwesomeIcons.arrowTrendUp : FontAwesomeIcons.arrowTrendDown,
                    size: AppSpacing.iconSm,
                    color: isIncrease ? AppColors.danger : AppColors.primaryLight,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    comparisonLabel!,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primaryLight,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}