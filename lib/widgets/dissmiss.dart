
import 'package:expens_tracker/export/export.dart';

class DismissibleExpenseTile extends StatelessWidget {
  const DismissibleExpenseTile({
    super.key,
    required this.expense,
    required this.dateLabel,
    required this.onTap,
    required this.onDelete,
  });

  final Expense expense;
  final String dateLabel;
  final VoidCallback onTap;
  final ValueChanged<Expense> onDelete;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(expense.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: AppSpacing.lg),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.error,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      onDismissed: (_) => onDelete(expense),
      child: ExpenseListTile(
        expense: expense,
        dateLabel: dateLabel,
        onTap: onTap,
      ),
    );
  }
}