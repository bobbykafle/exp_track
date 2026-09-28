import 'package:expens_tracker/export/export.dart';

class CategoryPicker extends StatelessWidget {
  const CategoryPicker({super.key,  this.selected, required this.onSelected});

  final ExpenseCategory? selected;
  final ValueChanged<ExpenseCategory> onSelected;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: AppSpacing.xs,
      crossAxisSpacing: AppSpacing.sm,
      childAspectRatio: 1.05,
      children: [
        for (final c in ExpenseCategory.values)
          _CategoryTile(
            category: c,
            isSelected: c == selected,
            onTap: () => onSelected(c),
          ),
      ],
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  final ExpenseCategory category;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = CategoryStyle.of(category);

    final bg = isSelected ? AppColors.categoryBg(category.label) : theme.cardTheme.color;
    final iconColor = isSelected
        ? AppColors.categoryFg(category.label)
        : theme.textTheme.bodyMedium?.color;

    return Semantics(
      button: true,
      selected: isSelected,
      label: category.label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: AppSpacing.categoryIconSize,
              height: AppSpacing.categoryIconSize,
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                border: Border.all(
                  color: isSelected ? style.accent : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Center(child: FaIcon(style.icon, size: 18, color: iconColor)),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              style.shortLabel,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? theme.colorScheme.onSurface : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}