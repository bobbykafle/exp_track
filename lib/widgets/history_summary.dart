import 'package:expens_tracker/export/export.dart';
import 'package:intl/intl.dart';

class HistorySummaryRow extends StatelessWidget {
  const HistorySummaryRow({super.key, required this.count, required this.total});

  final int count;
  final double total;

  @override
  Widget build(BuildContext context) {
    final money = NumberFormat.currency(symbol: r'$');
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$count ${count == 1 ? 'expense' : 'expenses'}',
            style: AppTextStyles.bodySmall,
          ),
          Text(
            money.format(total),
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}