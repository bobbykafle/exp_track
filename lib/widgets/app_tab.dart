import 'package:expens_tracker/export/export.dart';


class CategoryFilterBar extends StatelessWidget {
  const CategoryFilterBar({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final ExpenseCategory? selected;
  final ValueChanged<ExpenseCategory?> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
        children: [
          ChoiceChip(
            label: const Text('All'),
            selected: selected == null,
            onSelected: (_) => onChanged(null),
          ),
          for (final c in ExpenseCategory.values) ...[
            const SizedBox(width: AppSpacing.sm),
            ChoiceChip(
              label: Text(c.label),
              selected: selected == c,
              onSelected: (_) => onChanged(selected == c ? null : c),
            ),
          ],
        ],
      ),
    );
  }
}